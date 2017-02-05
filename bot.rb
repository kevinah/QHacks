require 'facebook/messenger'
include Facebook::Messenger
# NOTE: ENV variables should be set directly in terminal for testing on localhost
require 'uri'
require 'net/http'
require 'fastimage'
 
cog_url = URI("https://westus.api.cognitive.microsoft.com/face/v1.0/detect?returnFaceId=true&returnFaceLandmarks=true&returnFaceAttributes=age%2Cgender")

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
			message.reply(text: 'moustache mode is pending...')
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
		else
			message.reply(text: "I didn't understand that.")
		end
	end



=begin
	message.reply(
	  	attachment: {
	    		type: 'image',
	    		payload: {
	      		url: img_url
	    		}
	  	} 
	) 
=end
	#message.reply(text: 'ayy lmao')
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
	top2 = res[1]['faceRectangle']['top']
	left1 = res[0]['faceRectangle']['left']
	left2 = res[1]['faceRectangle']['left']
	width1 = res[0]['faceRectangle']['width']
	width2 = res[1]['faceRectangle']['width']
	height1 = res[0]['faceRectangle']['height']
	height2 = res[1]['faceRectangle']['height']
	#puts img_url
	
system("./application.linux64/QHacks '#{img_url}' '#{top1}' '#{left1}' '#{width1}' '#{height1}' '#{top2}' '#{left2}' '#{width2}' '#{height2}' '#{img_width}' '#{img_height}'") 



end  

