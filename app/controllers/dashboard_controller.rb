class DashboardController < ApplicationController
  before_action :authenticate_user!, only: [ :profile]
  def profile
    @user = current_user
    @properties = Property.where(user: @user)
    @reservations = Reservation.where(property: @properties)
  end
  
end
