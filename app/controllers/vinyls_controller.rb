require 'JSON'
require 'uri'
require 'net/http'
require 'openssl'

class VinylsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :set_vinyl, only: [:show, :edit, :update, :destroy]

  def index
    @vinyls = policy_scope(Vinyl).order(created_at: :desc)
	end

	def show
		# @rental = Rental.new
	end

  def new
    authorize current_user
    @vinyl = Vinyl.new

  end

  # def check_album


  #   @vinyls = []
  #   q_artist = params["vinyl"]["artist"]
  #   q_album = params["vinyl"]["album"]
  #   url = URI("https://deezerdevs-deezer.p.rapidapi.com/search?q=#{q_artist}")

  #   http = Net::HTTP.new(url.host, url.port)
  #   http.use_ssl = true
  #   http.verify_mode = OpenSSL::SSL::VERIFY_NONE

  #   while true

  #   request = Net::HTTP::Get.new(url)
  #   request["x-rapidapi-key"] = '8484d87f48msh17a33fcb2849ba2p10f605jsn1f2eb1a588ee'
  #   request["x-rapidapi-host"] = 'deezerdevs-deezer.p.rapidapi.com'
  #   request["accept-language"] = 'en-US'

  #   response = http.request(request)
  #   response.read_body
  #   result = JSON.parse(response.read_body)

  #   result["data"].select do |element|
  #     if element["album"]["title"] == q_album
  #       @vinyls << element["album"]
  #       @vinyls << Vinyl.new(
  #         title: album["title"],
  #         artist: album["artist"]["name"],
  #         genre: album["genres"]["data"][0]["name"],
  #         cover: album["cover"],
  #         cover_small: album["cover_small"],
  #         cover_medium: album["cover_medium"],
  #         cover_big: album["cover_big"],
  #         cover_xl: album["cover_xl"],
  #         album_api_id: album["id"],
  #         artist_api_id: album["artist"]["id"],
  #         price: rand(50..200)
  #         )
  #     end
  #   end

  #     if result["next"]
  #       url = result["next"]
  #     else
  #       break
  #     end
  #   end
  #   redirect_to select_vinyl_path(@vinyls)
  # end


  def create
    authorize current_user
    @vinyls = []
    q_artist = params["vinyl"]["artist"]
    q_album = params["vinyl"]["title"]
    url = URI("https://deezerdevs-deezer.p.rapidapi.com/search?q=#{q_artist}")

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
        if element["album"]["title"] == q_album
          @vinyls << element["album"]
          # @vinyls << Vinyl.new(
          #   title: element["album"]["title"],
          #   artist: element["album"]["artist"]["name"],
          #   genre: element["album"]["genres"]["data"][0]["name"],
          #   cover: element["album"]["cover"],
          #   cover_small: element["album"]["cover_small"],
          #   cover_medium: element["album"]["cover_medium"],
          #   cover_big: element["album"]["cover_big"],
          #   cover_xl: element["album"]["cover_xl"],
          #   album_api_id: element["album"]["id"],
          #   artist_api_id: element["album"]["artist"]["id"],
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
    redirect_to select_vinyl_path
    # redirect_to select_vinyl_path(@vinyls)
    # @vinyl = Vinyl.new(set_vinyl)

    # @vinyl.user = current_user

  end

  def select
    @vinyls = policy_scope(Vinyl).order(created_at: :desc)
  end

	def edit
	end

	def update
		if @vinyl.update(vinyl_params)
			redirect_to vinyl_path(@vinyl)
		else
			render :edit
		end
	end

	def destroy
		@vinyl.destroy
		redirect_to vinyls_path
	end

	private

	def vinyl_params
		params.require(:vinyl).permit(:title, :genre, :artist)
	end

  def set_vinyl
    @vinyl = Vinyl.find(params[:id])
    authorize @vinyl
  end
end
