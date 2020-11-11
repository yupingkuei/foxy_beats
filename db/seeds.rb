
# require 'JSON'
require 'uri'
require 'net/http'
require 'openssl'

puts 'destroying all Rentals...'
Rental.destroy_all

puts 'destroying all vinyls...'
Vinyl.destroy_all

puts 'destroying all users...'
User.destroy_all

puts "creating random users..."
20.times do
  User.create!(
    email: Faker::Internet.email,
    password: "123456",
    user_photo: Faker::Avatar.image(slug: "my-own-slug", size: "50x50", format: "jpg")
    )
end

url = URI("https://deezerdevs-deezer.p.rapidapi.com/search?q=t")

http = Net::HTTP.new(url.host, url.port)
http.use_ssl = true
http.verify_mode = OpenSSL::SSL::VERIFY_NONE

request = Net::HTTP::Get.new(url)
request["x-rapidapi-key"] = '8484d87f48msh17a33fcb2849ba2p10f605jsn1f2eb1a588ee'
request["x-rapidapi-host"] = 'deezerdevs-deezer.p.rapidapi.com'

response = http.request(request)
response.read_body
result = JSON.parse(response.read_body)
albums = []
tracks = result["data"].select do |element|
  albums << element["album"]["id"]
end

albums.each do |id|
  url = URI("https://deezerdevs-deezer.p.rapidapi.com/album/#{id}")
  http = Net::HTTP.new(url.host, url.port)
  http.use_ssl = true
  http.verify_mode = OpenSSL::SSL::VERIFY_NONE

  request = Net::HTTP::Get.new(url)
  request["x-rapidapi-key"] = '8484d87f48msh17a33fcb2849ba2p10f605jsn1f2eb1a588ee'
  request["x-rapidapi-host"] = 'deezerdevs-deezer.p.rapidapi.com'
  request["accept-language"] = 'en-US'

  response = http.request(request)
  album = JSON.parse(response.read_body)

  puts "creating vinyl for t..."
  vinyl = Vinyl.new(
    title: album["title"],
    artist: album["artist"]["name"],
    # genre: album["genres"]["data"][0]["name"],
    cover: album["cover"],
    cover_small: album["cover_small"],
    cover_medium: album["cover_medium"],
    cover_big: album["cover_big"],
    cover_xl: album["cover_xl"],
    album_api_id: album["id"],
    artist_api_id: album["artist"]["id"],
    price: rand(50..200)
  )
  user = User.all.sample
  vinyl.user = user
  vinyl.save
end

url = URI("https://deezerdevs-deezer.p.rapidapi.com/search?q=g")

http = Net::HTTP.new(url.host, url.port)
http.use_ssl = true
http.verify_mode = OpenSSL::SSL::VERIFY_NONE

request = Net::HTTP::Get.new(url)
request["x-rapidapi-key"] = '8484d87f48msh17a33fcb2849ba2p10f605jsn1f2eb1a588ee'
request["x-rapidapi-host"] = 'deezerdevs-deezer.p.rapidapi.com'

response = http.request(request)
response.read_body
result = JSON.parse(response.read_body)
albums = []
tracks = result["data"].select do |element|
  albums << element["album"]["id"]
end

albums.each do |id|
  url = URI("https://deezerdevs-deezer.p.rapidapi.com/album/#{id}")
  http = Net::HTTP.new(url.host, url.port)
  http.use_ssl = true
  http.verify_mode = OpenSSL::SSL::VERIFY_NONE

  request = Net::HTTP::Get.new(url)
  request["x-rapidapi-key"] = '8484d87f48msh17a33fcb2849ba2p10f605jsn1f2eb1a588ee'
  request["x-rapidapi-host"] = 'deezerdevs-deezer.p.rapidapi.com'
  request["accept-language"] = 'en-US'

  response = http.request(request)
  album = JSON.parse(response.read_body)

  puts "creating vinyl for g..."
  vinyl = Vinyl.new(
    title: album["title"],
    artist: album["artist"]["name"],
    # genre: album["genres"]["data"][0]["name"],
    cover: album["cover"],
    cover_small: album["cover_small"],
    cover_medium: album["cover_medium"],
    cover_big: album["cover_big"],
    cover_xl: album["cover_xl"],
    album_api_id: album["id"],
    artist_api_id: album["artist"]["id"],
    price: rand(50..200)
  )
  user = User.all.sample
  vinyl.user = user
  vinyl.save
end


url = URI("https://deezerdevs-deezer.p.rapidapi.com/search?q=n")

http = Net::HTTP.new(url.host, url.port)
http.use_ssl = true
http.verify_mode = OpenSSL::SSL::VERIFY_NONE

request = Net::HTTP::Get.new(url)
request["x-rapidapi-key"] = '8484d87f48msh17a33fcb2849ba2p10f605jsn1f2eb1a588ee'
request["x-rapidapi-host"] = 'deezerdevs-deezer.p.rapidapi.com'

response = http.request(request)
response.read_body
result = JSON.parse(response.read_body)
albums = []
tracks = result["data"].select do |element|
  albums << element["album"]["id"]
end

albums.each do |id|
  url = URI("https://deezerdevs-deezer.p.rapidapi.com/album/#{id}")
  http = Net::HTTP.new(url.host, url.port)
  http.use_ssl = true
  http.verify_mode = OpenSSL::SSL::VERIFY_NONE

  request = Net::HTTP::Get.new(url)
  request["x-rapidapi-key"] = '8484d87f48msh17a33fcb2849ba2p10f605jsn1f2eb1a588ee'
  request["x-rapidapi-host"] = 'deezerdevs-deezer.p.rapidapi.com'
  request["accept-language"] = 'en-US'

  response = http.request(request)
  album = JSON.parse(response.read_body)

  puts "creating vinyl for n..."
  vinyl = Vinyl.new(
    title: album["title"],
    artist: album["artist"]["name"],
    # genre: album["genres"]["data"][0]["name"],
    cover: album["cover"],
    cover_small: album["cover_small"],
    cover_medium: album["cover_medium"],
    cover_big: album["cover_big"],
    cover_xl: album["cover_xl"],
    album_api_id: album["id"],
    artist_api_id: album["artist"]["id"],
    price: rand(50..200)
  )
  user = User.all.sample
  vinyl.user = user
  vinyl.save
end

url = URI("https://deezerdevs-deezer.p.rapidapi.com/search?q=p")

http = Net::HTTP.new(url.host, url.port)
http.use_ssl = true
http.verify_mode = OpenSSL::SSL::VERIFY_NONE

request = Net::HTTP::Get.new(url)
request["x-rapidapi-key"] = '8484d87f48msh17a33fcb2849ba2p10f605jsn1f2eb1a588ee'
request["x-rapidapi-host"] = 'deezerdevs-deezer.p.rapidapi.com'

response = http.request(request)
response.read_body
result = JSON.parse(response.read_body)
albums = []
tracks = result["data"].select do |element|
  albums << element["album"]["id"]
end

albums.each do |id|
  url = URI("https://deezerdevs-deezer.p.rapidapi.com/album/#{id}")
  http = Net::HTTP.new(url.host, url.port)
  http.use_ssl = true
  http.verify_mode = OpenSSL::SSL::VERIFY_NONE

  request = Net::HTTP::Get.new(url)
  request["x-rapidapi-key"] = '8484d87f48msh17a33fcb2849ba2p10f605jsn1f2eb1a588ee'
  request["x-rapidapi-host"] = 'deezerdevs-deezer.p.rapidapi.com'
  request["accept-language"] = 'en-US'

  response = http.request(request)
  album = JSON.parse(response.read_body)

  puts "creating vinyl for p..."
  vinyl = Vinyl.new(
    title: album["title"],
    artist: album["artist"]["name"],
    # genre: album["genres"]["data"][0]["name"],
    cover: album["cover"],
    cover_small: album["cover_small"],
    cover_medium: album["cover_medium"],
    cover_big: album["cover_big"],
    cover_xl: album["cover_xl"],
    album_api_id: album["id"],
    artist_api_id: album["artist"]["id"],
    price: rand(50..200)
  )
  user = User.all.sample
  vinyl.user = user
  vinyl.save
end



50.times do
  puts "creating random rentals..."
  Rental.create!(
    user: User.all.sample,
    vinyl: Vinyl.all.sample,
    start_date: Date.today - rand(1..10),
    end_date: Date.today + rand(1..10)
    )
end
