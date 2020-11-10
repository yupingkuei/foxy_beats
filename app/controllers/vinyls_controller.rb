class VinylsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

	def index
    @vinyls = policy_scope(Vinyl).order(created_at: :desc)
	end

	def show
		@vinyl = Vinyl.find(params[:id])
    authorize @vinyl
	end

	def edit

		@vinyl = Vinyl.find(params[:id])
    authorize @vinyl
	end

	def update
		@vinyl = Vinyl.find(params[:id])
		if @vinyl.update(vinyl_params)
			redirect_to vinyl_path(@vinyl)
		else
			render :edit
		end
	end

	def destroy
		@vinyl = Vinyl.find(params[:id])
    authorize @vinyl
		@vinyl.destroy
		redirect_to vinyls_path
	end

	private
	def vinyl_params
		params.require(:vinyl).permit(:title, :genre, :artist)
	end

  def set_vinyl
    @vinyl = Vinyl.find(param[:id])
  end
end
