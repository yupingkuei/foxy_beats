require 'uri'
require 'net/http'
require 'openssl'


albums = []
search = "eminem"
s_album = "The Slim Shady LP"
url = URI("https://deezerdevs-deezer.p.rapidapi.com/search?q=#{search}")

http = Net::HTTP.new(url.host, url.port)
http.use_ssl = true
http.verify_mode = OpenSSL::SSL::VERIFY_NONE

while true

request = Net::HTTP::Get.new(url)
request["x-rapidapi-key"] = '8484d87f48msh17a33fcb2849ba2p10f605jsn1f2eb1a588ee'
request["x-rapidapi-host"] = 'deezerdevs-deezer.p.rapidapi.com'
request["accept-language"] = 'en-US'

response = http.request(request)
response.read_body
result = JSON.parse(response.read_body)

result["data"].select do |element|
  if element["album"]["title"] == s_album
    albums << element["album"]
    # albums << Vinyl.new(
    #   title: album["title"],
    #   artist: album["artist"]["name"],
    #   genre: album["genres"]["data"][0]["name"],
    #   cover: album["cover"],
    #   cover_small: album["cover_small"],
    #   cover_medium: album["cover_medium"],
    #   cover_big: album["cover_big"],
    #   cover_xl: album["cover_xl"],
    #   album_api_id: album["id"],
    #   artist_api_id: album["artist"]["id"],
    #   price: rand(50..200)
    #   )
  end
end

  if result["next"]
    url = result["next"]
  else
    break
  end
end

albums.uniq
album = albums.first
p album["title"]


# albums.each do |id|
#   url = URI("https://deezerdevs-deezer.p.rapidapi.com/album/#{id}")
#   http = Net::HTTP.new(url.host, url.port)
#   http.use_ssl = true
#   http.verify_mode = OpenSSL::SSL::VERIFY_NONE

#   request = Net::HTTP::Get.new(url)
#   request["x-rapidapi-key"] = '8484d87f48msh17a33fcb2849ba2p10f605jsn1f2eb1a588ee'
#   request["x-rapidapi-host"] = 'deezerdevs-deezer.p.rapidapi.com'
#   request["accept-language"] = 'en-US'

#   response = http.request(request)
#   album = JSON.parse(response.read_body)
#   p album["title"]
# end
