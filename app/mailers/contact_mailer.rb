class ContactMailer < ApplicationMailer
  def contact_email(name, email, message)
    @name = name
    @message = message
    mail(to: 'larrieu.aurelien@gmail.com', subject: 'Nouveau message de contact') do |format|
      format.text { render plain: "Nom: #{@name}\nEmail: #{email}\nMessage: #{@message}" }
    end
  end
end
