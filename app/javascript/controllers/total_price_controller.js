import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="total-price"
export default class extends Controller {
  static values = { priceperday: Number }
  static targets = ["startDate", "endDate", "totalPrice"]

  connect() {
    console.log("total_price_controller connected");
    const pricePerDay = this.priceperdayValue;
    console.log(`Price per day: ${pricePerDay}`); // Doit afficher 75
    console.log("Start date target:", this.startDateTarget);
    console.log("End date target:", this.endDateTarget);
  }

  calculPrice() {
    console.log("Calculating price...");

    // Convertir les dates en format ISO (assurez-vous que les inputs sont au format Y-m-d)
    const startDate = new Date(this.startDateTarget.value);
    const endDate = new Date(this.endDateTarget.value);

    console.log("Start Date:", startDate);
    console.log("End Date:", endDate);

    // Vérifier si les dates sont valides
    if (startDate instanceof Date && !isNaN(startDate) && endDate instanceof Date && !isNaN(endDate) && startDate < endDate) {
        const diffTime = Math.abs(endDate - startDate);
        const diffDays = Math.ceil(diffTime / (1000 * 60 * 60 * 24));
        console.log("Days Difference:", diffDays);

        const pricePerDay = this.priceperdayValue;
        const totalPrice = diffDays * pricePerDay ;
        console.log("Total Price:", totalPrice);

        this.totalPriceTarget.value = totalPrice.toFixed(2);
    } else {
        console.error("Invalid dates or order");
    }
  }
}
