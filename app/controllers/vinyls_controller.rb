class VinylsController < ApplicationController

	def index
		@vinyls = Vinyl.all
	end

	def show
		@vinyl = Vinyl.find(params[:id])
	end

	def edit
		@vinyl = Vinyl.find(params[:id])
	end

	def update
		@vinyl - Vinyl.find(params[:id])
		if @vinyl.update(vinyl_params)
			redirect_to vinyl_path(@vinyl)
		else
			render :edit
		end
	end

	private
	def vinyl_params
		params.require(:vinyl).permit(:title, :genre, :artist)
	end
end
