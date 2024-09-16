class PropertiesController < ApplicationController

  def index
    @properties = Property.all

  end

  def show
    @property = Property.find(params[:id])
    @reservation = Reservation.new
  end

  def new
    @property = Property.new
  end




  def create
    @property = Property.new(property_params)
    if @property.save
      redirect_to properties_path
    else
      render :new
    end
  end

  private

  def property_params
    params.require(:property).permit(:name, :address, :description, :price, :number_of_guests, :number_of_bedrooms, :number_of_bathrooms, :equipments)
  end
end
