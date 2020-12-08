require 'uri'
require 'net/http'
require 'openssl'

class VinylsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :set_vinyl, only: [:show, :edit, :update, :destroy]

  def index
    if params[:query].present?
      @vinyls = policy_scope(Vinyl).search_by_title_and_artist(params[:query])
    else
      @vinyls = policy_scope(Vinyl).order(created_at: :desc)
    end
  end

  def show
    @rental = Rental.new
  end

  def new
    authorize current_user
    @new_vinyl = Vinyl.new
    if params[:artist].present?
      @vinyls = filter(params["artist"], params["title"])
      @price = params["price"].to_i
      @condition = params["condition"]
    else
      true
    end
  end

  def create
    @vinyl = Vinyl.new(vinyl_params)
    authorize @vinyl
    @vinyl.user = current_user
    if @vinyl.save
      redirect_to vinyl_path(@vinyl)
    else
      render :new
    end
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
    redirect_to dashboard_path
  end

  private

  def vinyl_params
    params.require(:vinyl).permit(:title, :artist, :cover, :cover_small, :cover_medium, :cover_big, :cover_xl, :album_api_id, :artist_api_id, :condition, :price)
  end

  def set_vinyl
    @vinyl = Vinyl.find(params[:id])
    authorize @vinyl
  end

  def filter(q_artist, q_album)
    vinyls = []
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
      if result["data"]
        result["data"].select do |element|
          next unless element["artist"]
          if element["album"]["title"].downcase.include?( q_album.downcase)
            vinyls << Vinyl.new(
              title: element["album"]["title"],
              artist: element["artist"]["name"],
              # genre: element["genres"]["data"][0]["name"],
              cover: element["album"]["cover"],
              cover_small: element["album"]["cover_small"],
              cover_medium: element["album"]["cover_medium"],
              cover_big: element["album"]["cover_big"],
              cover_xl: element["album"]["cover_xl"],
              album_api_id: element["album"]["id"],
              artist_api_id: element["artist"]["id"],
              price: 0
            )
          end
        end
      end
      result["next"] ? url = result["next"] : break
    end
    vinyls.uniq{|vinyl| vinyl.title}
  end
end
