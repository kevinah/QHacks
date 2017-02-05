require 'uri'
require 'net/http'
require 'json'

url = URI("https://westus.api.cognitive.microsoft.com/emotion/v1.0/recognize")

http = Net::HTTP.new(url.host, url.port)
http.use_ssl = true
# http.verify_mode = OpenSSL::SSL::VERIFY_NONE

request = Net::HTTP::Post.new(url)
request["ocp-apim-subscription-key"] = #API KEY HERE
request["content-type"] = 'application/json'
request["cache-control"] = 'no-cache'
request["postman-token"] = '1f0a089a-a2e9-9f9c-c923-ad27c29b6e3c'
request.body = "{ \n\t\"url\": \"http://i.imgur.com/MaClrNN.jpg\" \n}"

response = http.request(request)
res = response.read_body

res = JSON.parse(res)

top_score = 0
top_score_index = 0

index = 0
res.each do |face|
	happiness = face['scores']['happiness']
	if happiness > top_score
		top_score = happiness
		top_score_index = index
	end
	index += 1
end

puts "top score: #{top_score}"
puts "face index: #{top_score_index}"

puts res[top_score_index]['faceRectangle']