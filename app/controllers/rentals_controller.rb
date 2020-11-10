class RentalsController < ApplicationController
  def new
    @rental = Rental.new
    @vinyl = Vinyl.find(params[:vinyl_id])
  end

  def create
    @rental = Rental.new(rental_params)
    @vinyl = Vinyl.find(params[:vinyl_id])
    @rental.user = current_user
    @rental.vinyl = @vinyl
    if @rental.save
      redirect_to vinyl_path(@vinyl)
    else
      render "vinyls/show"
    end
  end

  private

  def rental_params
    params.require(:rental).permit(:vinyl_id, :user_id, :price, :start_date, :end_date, :status)
  end
end
