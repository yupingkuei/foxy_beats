class VinylsController < ApplicationController

  def index
    @vinyls = Vinyl.all
  end

  def show
    @vinyl = Vinyl.find(params[:id])
    @rental = Rental.new
  end
end
