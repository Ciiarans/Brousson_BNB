import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static values = { priceperday: Number, cleaningprice: Number };
  static targets = ["startDate", "endDate", "totalPrice", "addCleaning"]

  connect() {
    console.log("total_price_controller connected");
    this.cleaningprice = parseFloat(this.element.getAttribute("data-total-price-cleaningprice-value")) || 0;
    console.log("Cleaning price:", this.cleaningprice); // Vérifie si la valeur est correcte
  }

  calculPrice() {
    const startDate = new Date(this.startDateTarget.value);
    const endDate = new Date(this.endDateTarget.value);

    if (!isNaN(startDate) && !isNaN(endDate) && startDate < endDate) {
      const diffDays = Math.ceil((endDate - startDate) / (1000 * 60 * 60 * 24));
      const pricePerDay = this.priceperdayValue;
      const cleaningPrice = this.addCleaningTarget.checked ? this.cleaningprice : 0; // Utiliser this.cleaningPrice ici
      const totalPrice = (diffDays * pricePerDay) + cleaningPrice;

      this.totalPriceTarget.textContent = totalPrice.toFixed(2) + " €";
      this.updateModalPrice(totalPrice);
    } else {
      console.error("Invalid dates or order");
    }
  }

  updateModalPrice(totalPrice) {
    const modalTotalPrice = document.getElementById("modalTotalPrice");
    const hiddenTotalPrice = document.getElementById("hiddenTotalPrice");

    if (modalTotalPrice) {
      modalTotalPrice.textContent = totalPrice.toFixed(2) + " €";
      hiddenTotalPrice.value = totalPrice.toFixed(2);
    }
  }
}
