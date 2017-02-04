require 'facebook/messenger'
include Facebook::Messenger
# NOTE: ENV variables should be set directly in terminal for testing on localhost
require 'uri'
require 'net/http'
 
cog_url = URI("https://westus.api.cognitive.microsoft.com/face/v1.0/detect?returnFaceId=true&returnFaceLandmarks=true&returnFaceAttributes=age%2Cgender")

http = Net::HTTP.new(cog_url.host, cog_url.port)
http.use_ssl = true
http.verify_mode = OpenSSL::SSL::VERIFY_NONE
 
# Subcribe bot to your page
Facebook::Messenger::Subscriptions.subscribe(access_token: ENV["ACCESS_TOKEN"])
 
Bot.on :message do |message|
	#text: message.text)

	puts "***" + message.attachments.to_s
	img_url = message.attachments[0]['payload']['url']

	getInfo(cog_url, img_url, http)

	message.reply(
	  	attachment: {
	    		type: 'image',
	    		payload: {
	      		url: img_url
	    		}
	  	} 
	)

	message.reply(text: 'ayy lmao')
end

def getInfo(cog_url, img_url, http)  
  request = Net::HTTP::Post.new(cog_url)
  request["ocp-apim-subscription-key"] = File.open('apikey', &:readline)[0..-2]
  request["content-type"] = 'application/json'
  request["cache-control"] = 'no-cache'
  request["postman-token"] = 'd87b9b8d-fdb5-6e88-252a-8f2188af1b3e'
  request.body = "{\r\n    \"url\":\"" + img_url + "\"\r\n}"
 
  response = http.request(request) 
  puts response.read_body
end  

