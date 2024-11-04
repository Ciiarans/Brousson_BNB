class ContactsController < ApplicationController
  def contact
    name = params[:name]
    email = params[:email]
    message = params[:message]

    # Use ContactMailer instead of YourMailer
    if ContactMailer.contact_email(name, email, message).deliver_now
      flash[:success] = "Votre message a été envoyé !"
      redirect_to properties_path # Change this to your desired redirect path
    else
      raise
      flash[:error] = "Erreur lors de l'envoi de votre message."
      render :index # Render the index view again if sending fails
    end
  end
end
