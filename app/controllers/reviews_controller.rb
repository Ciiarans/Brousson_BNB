# app/controllers/reviews_controller.rb
class ReviewsController < ApplicationController

  def new
    @review = Review.new
    @properties = Property.all # pour afficher les propriétés dans le formulaire
  end

  def create
    @review = Review.new(review_params)
    if @review.save
      # Rediriger vers la page d'accueil après la création de l'avis
      redirect_to root_path, notice: 'Avis ajouté avec succès !'
    else
      render :new, alert: 'Erreur lors de l\'ajout de l\'avis.'
    end
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    redirect_to root_path, notice: 'Avis supprimé avec succès.'
  end

  private

  def review_params
    params.require(:review).permit(:reviewer_name, :rating, :comment, :property_id)
  end
end
