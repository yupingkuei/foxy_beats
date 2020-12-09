require 'uri'
require 'net/http'
require 'openssl'

puts 'destroying all Rentals...'
Rental.destroy_all

puts 'destroying all vinyls...'
Vinyl.destroy_all

puts 'destroying all users...'
User.destroy_all

puts 'creating random users...'
20.times do
  User.create!(
    email: Faker::Internet.email,
    password: '123456',
    user_photo:
      Faker::Avatar.image(slug: 'my-own-slug', size: '50x50', format: 'jpg'),
    nickname: Faker::Hipster.word,
    address: Faker::Address.street_address
  )
end

def random_seed(q_artist, q_album = '')
  vinyls = []
  url = URI("https://deezerdevs-deezer.p.rapidapi.com/search?q=#{q_artist}")
  http = Net::HTTP.new(url.host, url.port)
  http.use_ssl = true
  http.verify_mode = OpenSSL::SSL::VERIFY_NONE

  while true
    request = Net::HTTP::Get.new(url)
    request['x-rapidapi-key'] =
      '8484d87f48msh17a33fcb2849ba2p10f605jsn1f2eb1a588ee'
    request['x-rapidapi-host'] = 'deezerdevs-deezer.p.rapidapi.com'
    request['accept-language'] = 'en-US'
    response = http.request(request)
    response.read_body
    result = JSON.parse(response.read_body)
    if result['data']
      result['data'].select do |element|
        next unless element['artist']
        if element['album']['title'].downcase.include?(q_album.downcase)
          vinyls <<
            Vinyl.new(
              title: element['album']['title'],
              artist: element['artist']['name'],
              cover: element['album']['cover'],
              cover_small: element['album']['cover_small'],
              cover_medium: element['album']['cover_medium'],
              cover_big: element['album']['cover_big'],
              cover_xl: element['album']['cover_xl'],
              album_api_id: element['album']['id'],
              artist_api_id: element['artist']['id'],
              condition: Vinyl::CONDITIONS.sample,
              price: rand(50..200),
              user: User.all.sample
            )
        end
      end
    end
    result['next'] ? url = result['next'] : break
  end
  vinyls.uniq { |vinyl| vinyl.title }.each { |vinyl| vinyl.save }
end
puts 'seeding for b...'
random_seed('b')
puts 'seeding for h...'
random_seed('h')
puts 'seeding for n...'
random_seed('n')
puts 'seeding for p...'
random_seed('p')

50.times do
  puts 'creating random rentals...'
  Rental.create!(
    user: User.all.sample,
    vinyl: Vinyl.all.sample,
    start_date: Date.today - rand(1..10),
    end_date: Date.today + rand(1..10)
  )
end

puts 'creating store'
store =
  User.new(
    email: 'chaz@hipster.af.com',
    password: '123456',
    user_photo: 'fox.jpg',
    nickname: 'Pure Vegan',
    address: 'Hokkaido'
  )
store.save

puts 'creating yuping'
yuping =
  User.new(
    email: 'yuping@gmail.com',
    password: '123456',
    user_photo: 'yuping.jpg',
    nickname: 'Yuping',
    address: 'Tokyo'
  )
yuping.save

puts 'stocking store'
Vinyl.all.first(20).each do |vinyl|
  vinyl.user = store
  vinyl.save
end
