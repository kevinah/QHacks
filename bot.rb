require 'facebook/messenger'
include Facebook::Messenger
# NOTE: ENV variables should be set directly in terminal for testing on localhost
require 'uri'
require 'net/http'
require 'fastimage'
 
cog_url = URI("https://westus.api.cognitive.microsoft.com/face/v1.0/detect?returnFaceId=true&returnFaceLandmarks=true&returnFaceAttributes=age%2Cgender")
emo_url = URI("https://westus.api.cognitive.microsoft.com/emotion/v1.0/recognize")

http = Net::HTTP.new(cog_url.host, cog_url.port)
http.use_ssl = true
http.verify_mode = OpenSSL::SSL::VERIFY_NONE
 
# Subcribe bot to your page
Facebook::Messenger::Subscriptions.subscribe(access_token: ENV["ACCESS_TOKEN"])

Bot.on :message do |message|

	#puts request.base_url
	#puts message.attachments.to_s
	if(message.attachments)
		puts "we are dealing with an image"
		
		if(File.open('mode', &:readline) == "faceswap")
			img_url = message.attachments[0]['payload']['url']
			#puts img_url

			dimensions = FastImage.size(img_url);

			img_width = dimensions[0];
			img_height = dimensions[1];

			puts img_width
			puts img_height

			getCoorInfo(cog_url, img_url, http, img_width, img_height)



			message.reply(
			  	attachment: {
			    		type: 'image',
			    		payload: {
			      		url: 'https://f0d9fabc.ngrok.io/images/test_img.png'
			    		}
			  	} 
			)
			message.reply(text: 'You got SWAPPED!')	
		elsif (File.open('mode', &:readline) == "moustache")
			img_url = message.attachments[0]['payload']['url']
				#puts img_url

				dimensions = FastImage.size(img_url);
	
				img_width = dimensions[0];
				img_height = dimensions[1];
	
				puts img_width
				puts img_height
	
				getCoorInfo(cog_url, img_url, http, img_width, img_height)

	

				message.reply(
				  	attachment: {
				    		type: 'image',
				    		payload: {
				      		url: 'https://f0d9fabc.ngrok.io/images/test_img.png'
				    		}
				  	} 
				)
			message.reply(text: "Soon we'll be putting moustaches on cats and dogs and... snakes.")
		elsif (File.open('mode', &:readline) == "smile")
			img_url = message.attachments[0]['payload']['url']
			#puts img_url

			dimensions = FastImage.size(img_url);

			img_width = dimensions[0];
			img_height = dimensions[1];

			findHappiest(emo_url, img_url, http, img_width, img_height)

			message.reply(
				  	attachment: {
				    		type: 'image',
				    		payload: {
				      		url: 'https://f0d9fabc.ngrok.io/images/test_img.png'
				    		}
				  	} 
				)
			message.reply(text: "Winner!!!")	
		else
			message.reply(text: 'Please set mode!')
		end

	else
		puts "we are dealing with text"	
		if (message.text == "FACESWAP!")
			File.write('mode', 'faceswap')
			message.reply(text: 'Ready to faceswap! Send an image!')
		elsif (message.text == "GIMME STACHE!")	
			File.write('mode', 'moustache')
			message.reply(text: 'Ready to moustache-ify! Send an image!')
		elsif (message.text == "SMILING CONTEST!")	
			File.write('mode', 'smile')
			message.reply(text: 'Smile as big as you can, whoever looks happiest wins!')

		elsif (message.text == "GREEN ME!")
			dimensions = FastImage.size('https://f0d9fabc.ngrok.io/images/test_img.png');
			img_width = dimensions[0];
			img_height = dimensions[1];
			doGreen(gWid, gHei);
			message.reply(
				  attachment: {
				    	type: 'image',
				    	payload: {
				  		url: 'https://f0d9fabc.ngrok.io/images/test_img.png'
			    		}
			  	} 
			)
		else
			message.reply(text: "I didn't understand that.")
		end
	end

	#message.reply(text: 'ayy lmao')
end

def doGreen(gWid, gHei) 
	system("./Greenify/application.linux64/Greenify '#{gWid}' '#{gHei}'")
end

def findHappiest(emo_url, img_url, http, img_width, img_height)
	request = Net::HTTP::Post.new(emo_url)
	request["ocp-apim-subscription-key"] = File.open('apikey2', &:readline)[0..-2]
	request["content-type"] = 'application/json'
	request["cache-control"] = 'no-cache'
	request["postman-token"] = '1f0a089a-a2e9-9f9c-c923-ad27c29b6e3c'
	request.body = "{ \n\t\"url\": \"" + img_url + "\" \n}"

	response = http.request(request)
	res = response.read_body

	res = JSON.parse(res)

	top_score = 0
	top_score_index = 0

	index = 0
	puts res
	res.each do |face|
		happiness = face['scores']['happiness']
		if happiness > top_score
			top_score = happiness
			top_score_index = index
		end
		index += 1
	end
	
	top = res[top_score_index]['faceRectangle']['top']
	left = res[top_score_index]['faceRectangle']['left']
	width = res[top_score_index]['faceRectangle']['width']
	height = res[top_score_index]['faceRectangle']['height']
		
	
	system("./Happy/application.linux64/Happy '#{img_url}' '#{top}' '#{left}' '#{width}' '#{height}' '#{img_width}' '#{img_height}'")
end

def getCoorInfo(cog_url, img_url, http, img_width, img_height)  
  request = Net::HTTP::Post.new(cog_url)
  request["ocp-apim-subscription-key"] = File.open('apikey', &:readline)[0..-2]
  request["content-type"] = 'application/json'
  request["cache-control"] = 'no-cache'
  request["postman-token"] = 'd87b9b8d-fdb5-6e88-252a-8f2188af1b3e'
  request.body = "{\r\n    \"url\":\"" + img_url + "\"\r\n}"
 
  response = http.request(request) 
  #puts response.read_body
  res = response.read_body
  res = JSON.parse(res)
  #puts res
    
=begin
  res.each do |face|
    puts "***"
	puts face['faceRectangle']
	puts 'left pupil: ' + face['faceLandmarks']['pupilLeft'].to_s
	puts 'right pupil: ' + face['faceLandmarks']['pupilRight'].to_s
	puts 'nose tip: ' + face['faceLandmarks']['noseTip'].to_s
	puts 'mouth left: ' + face['faceLandmarks']['mouthLeft'].to_s
	puts 'mouth right: ' + face['faceLandmarks']['mouthRight'].to_s
  end
=end

	top1 = res[0]['faceRectangle']['top']
	left1 = res[0]['faceRectangle']['left']
	width1 = res[0]['faceRectangle']['width']
	height1 = res[0]['faceRectangle']['height']
	pupilLeftx1 = res[0]['faceLandmarks']['pupilLeft']['x']
	pupilLefty1 = res[0]['faceLandmarks']['pupilLeft']['y']
	pupilRightx1 = res[0]['faceLandmarks']['pupilRight']['x']
	pupilRighty1 = res[0]['faceLandmarks']['pupilRight']['y']
	noseTipx1 = res[0]['faceLandmarks']['noseTip']['x']
	noseTipy1 = res[0]['faceLandmarks']['noseTip']['y']
	mouthLeftx1 = res[0]['faceLandmarks']['mouthLeft']['x']
	mouthLefty1 = res[0]['faceLandmarks']['mouthLeft']['y']
	mouthRightx1 = res[0]['faceLandmarks']['mouthRight']['x']
	mouthRighty1 = res[0]['faceLandmarks']['mouthRight']['y']
	
	#puts img_url
	top2 = res[1]['faceRectangle']['top']
	left2 = res[1]['faceRectangle']['left']
	width2 = res[1]['faceRectangle']['width']
	height2 = res[1]['faceRectangle']['height']
	pupilLeftx2 = res[1]['faceLandmarks']['pupilLeft']['x']
	pupilLefty2 = res[1]['faceLandmarks']['pupilLeft']['y']
	pupilRightx2 = res[1]['faceLandmarks']['pupilRight']['x']
	pupilRighty2 = res[1]['faceLandmarks']['pupilRight']['y']
	noseTipx2 = res[1]['faceLandmarks']['noseTip']['x']
	noseTipy2 = res[1]['faceLandmarks']['noseTip']['y']
	mouthLeftx2 = res[1]['faceLandmarks']['mouthLeft']['x']
	mouthLefty2 = res[1]['faceLandmarks']['mouthLeft']['y']
	mouthRightx2 = res[1]['faceLandmarks']['mouthRight']['x']
	mouthRighty2 = res[1]['faceLandmarks']['mouthRight']['y']

	mode = File.open('mode', &:readline);

system("./application.linux64/QHacks '#{img_url}' '#{top1}' '#{left1}' '#{width1}' '#{height1}' '#{pupilLeftx1}' '#{pupilLefty1}' '#{pupilRightx1}' '#{pupilRighty1}' '#{noseTipx1}' '#{noseTipy1}' '#{mouthLeftx1}' '#{mouthLefty1}' '#{mouthRightx1}' '#{mouthRighty1}' " + "'#{top2}' '#{left2}' '#{width2}' '#{height2}' '#{pupilLeftx2}' '#{pupilLefty2}' '#{pupilRightx2}' '#{pupilRighty2}' '#{noseTipx2}' '#{noseTipy2}' '#{mouthLeftx2}' '#{mouthLefty2}' '#{mouthRightx2}' '#{mouthRighty2}' " + "'#{img_width}' '#{img_height}' '#{mode}'") 



end  

