class RentalsController < ApplicationController
  def new
    @rental = Rental.new
    @vinyl = Vinyl.find(params[:vinyl_id])
    authorize @rental
  end

  def create
    @rental = Rental.new(rental_params)
    @vinyl = Vinyl.find(params[:vinyl_id])
    @rental.user = current_user
    @rental.vinyl = @vinyl
    authorize @rental
    if @rental.save
      redirect_to dashboard_path
    else
      render "vinyls/show"
    end
  end

  def update
    @rental = Rental.find(params[:id])
    authorize @rental
    if @rental.update(rental_params)
      redirect_to dashboard_path
    end
  end

  def destroy
    @rental = Rental.find(params[:id])
    authorize @rental
    @rental.destroy
    redirect_to dashboard_path
  end
  private

  def rental_params
    params.require(:rental).permit(:vinyl_id, :user_id, :start_date, :end_date, :status)
  end
end
