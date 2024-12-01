import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static values = { priceperday: Number, cleaningprice: Number, addcleaning: Boolean };
  static targets = ["startDate", "endDate", "totalPrice", "addCleaning"]

  connect() {
    console.log("total_price_controller connected");
    this.cleaningprice = parseFloat(this.element.getAttribute("data-total-price-cleaningprice-value")) || 0;
    console.log("Cleaning price:", this.cleaningprice); // Vérifie si la valeur est correcte
    this.addCleaningTarget.checked = this.addcleaningValue;
    console.log("addCleaningValue:", this.addcleaningValue)
  }

  calculPrice() {
    const startDateParts = this.startDateTarget.value.split('-');
    const endDateParts = this.endDateTarget.value.split('-');
    const startDate = new Date(startDateParts[2], startDateParts[1] - 1, startDateParts[0]);
    const endDate = new Date(endDateParts[2], endDateParts[1] - 1, endDateParts[0]);
    const buttonmodal = document.getElementById("buttonmodal");
    console.log("Start date:", startDate);
    console.log("End date:", endDate);

    if (!isNaN(startDate) && !isNaN(endDate) && startDate < endDate) {
      const diffDays = Math.ceil((endDate - startDate) / (1000 * 60 * 60 * 24));
      console.log("Difference in days:", diffDays);

      const pricePerDay = this.priceperdayValue;
      console.log("Price per day:", pricePerDay);

      const cleaningPrice = this.addCleaningTarget.checked ? this.cleaningprice : 0;
      console.log("Cleaning price:", cleaningPrice);
      console.log("addCleaning:", this.addCleaningTarget)

      const totalPrice = (diffDays * pricePerDay) + cleaningPrice;
      console.log("Total price:", totalPrice);


      this.totalPriceTarget.textContent = totalPrice.toFixed(2) + " €";
      this.updateModalPrice(totalPrice);

      buttonmodal.disabled = false; // activer le bouton
      buttonmodal.classList.remove('btn-disabled'); // Ajouter la classe CSS pour le style
    } else {
      buttonmodal.disabled = true; // Activer le bouton
      buttonmodal.classList.add('btn-disabled'); // Ajouter la classe CSS pour le style
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

    cleaningStatus() {
    const cleaning = this.addCleaningTarget;
    const modalAddCleaning = document.getElementById("modalAddCleaning");
    const hiddenAddCleaning = document.getElementById("hiddenAddCleaning");

    if (cleaning.checked) {
      this.addcleaningValue = 1;
      hiddenAddCleaning.value = 1;
      modalAddCleaning.textContent = "Frais de Ménage inclus dans le prix.";

      console.log("Cleaning added : ", this.addcleaningValue);
      console.log("Cleaning added (hidden): ", hiddenAddCleaning.value);
    }
    else {
      this.addcleaningValue = 0;
      hiddenAddCleaning.value = 0;
      modalAddCleaning.textContent = "Ménage non inclus dans le prix";
      console.log("Cleaning removed : " , this.addcleaningValue);
      console.log("Cleaning removed (hidden): ", hiddenAddCleaning.value);
    }
  }
}
