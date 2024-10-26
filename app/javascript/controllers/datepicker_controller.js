import { Controller } from "@hotwired/stimulus";
import flatpickr from "flatpickr";

// Connects to data-controller="datepicker"
export default class extends Controller {
  static targets = ["startInput", "endInput"];

  connect() {
    this.initFlatpickr();
  }

  initFlatpickr() {
    flatpickr(this.startInputTarget, {
      dateFormat: "d/m/Y",
      mode: "range",
      minDate: "today",
      monthSelectorType: "short",
      onChange: this.handleDateChange.bind(this),
    });

    flatpickr(this.endInputTarget, {
      dateFormat: "d/m/Y",
      mode: "range",
      minDate: "today",
      monthSelectorType: "short",
      onChange: this.handleDateChange.bind(this),
    });
  }

  handleDateChange(selectedDates) {
    if (selectedDates.length === 2) {
      const startDate = selectedDates[0].toISOString().split('T')[0];
      const endDate = selectedDates[1].toISOString().split('T')[0];

      this.startInputTarget.value = startDate;
      this.endInputTarget.value = endDate;

      // Mettre à jour les éléments de la modale avec les dates
      const modalStartDate = document.getElementById("modalStartDate");
      const modalEndDate = document.getElementById("modalEndDate");
      const hiddenStartDate = document.getElementById("hiddenStartDate"); // Ajouté pour input caché
      const hiddenEndDate = document.getElementById("hiddenEndDate"); // Ajouté pour input caché

      modalStartDate.textContent = startDate;
      modalEndDate.textContent = endDate;

      // Mise à jour des inputs cachés
      hiddenStartDate.value = startDate;
      hiddenEndDate.value = endDate;

      // Déclencher l'événement change manuellement
      this.startInputTarget.dispatchEvent(new Event('change'));
      this.endInputTarget.dispatchEvent(new Event('change'));
    }
  }

  handleCalendarReady(selectedDates, dateStr, instance) {
    this.setInitialDates(selectedDates);
  }

  setInitialDates(selectedDates) {
    if (selectedDates.length === 2) {
      const startDate = selectedDates[0].toISOString().split('T')[0];
      const endDate = selectedDates[1].toISOString().split('T')[0];

      this.startInputTarget.value = startDate;
      this.endInputTarget.value = endDate;

      // Mettre à jour les éléments de la modale avec les dates
      const modalStartDate = document.getElementById("modalStartDate");
      const modalEndDate = document.getElementById("modalEndDate");

      modalStartDate.textContent = startDate;
      modalEndDate.textContent = endDate;
    }
  }
}
