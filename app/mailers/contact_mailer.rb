class ContactMailer < ApplicationMailer
  def contact_email(name, email, message)
    @name = name
    @message = message
    mail(to: 'contact.pat.immo@gmail.com', subject: 'Demande de renseignement') do |format|
      format.text { render plain: "Nom: #{@name}\nEmail: #{email}\nMessage: #{@message}" }
    end
  end
end
