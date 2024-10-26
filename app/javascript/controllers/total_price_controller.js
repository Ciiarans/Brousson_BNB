import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="total-price"
export default class extends Controller {
  static values = { priceperday: Number }
  static targets = ["startDate", "endDate", "totalPrice"]

  connect() {
    console.log("total_price_controller connected");
  }

  calculPrice() {
    console.log("Calculating price...");

    const startDate = new Date(this.startDateTarget.value);
    const endDate = new Date(this.endDateTarget.value);

    if (startDate instanceof Date && !isNaN(startDate) && endDate instanceof Date && !isNaN(endDate) && startDate < endDate) {
        const diffTime = Math.abs(endDate - startDate);
        const diffDays = Math.ceil(diffTime / (1000 * 60 * 60 * 24));
        const pricePerDay = this.priceperdayValue;
        const totalPrice = diffDays * pricePerDay;

        this.totalPriceTarget.textContent = totalPrice.toFixed(2) + " €"; // Assurez-vous que ceci est textContent
        this.updateModalPrice(totalPrice);
    } else {
        console.error("Invalid dates or order");
    }
  }

  updateModalPrice(totalPrice) {
    const modalTotalPrice = document.getElementById("modalTotalPrice");
    const hiddenTotalPrice = document.getElementById("hiddenTotalPrice"); // Ajouté pour input caché

    if (modalTotalPrice) {
      modalTotalPrice.textContent = totalPrice.toFixed(2) + " €";
      hiddenTotalPrice.value = totalPrice.toFixed(2); // Mise à jour de l'input caché
    }
  }
}
