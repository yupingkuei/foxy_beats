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
