import { Controller } from "@hotwired/stimulus";
import flatpickr from "flatpickr";


// Connects to data-controller="datepicker"
export default class extends Controller {
  static targets = ["startInput", "endInput"];

  connect() {
    this.fp = flatpickr(this.startInputTarget, {
      mode: "range",

      dateFormat: "Y-m-d",  // Utilisation du format ISO compatible avec la classe JavaScript Date
      minDate: "today",
      monthSelectorType: "short",
      onChange: this.handleDateChange.bind(this),
      onReady: this.handleCalendarReady.bind(this),
    });
  }

  handleDateChange(selectedDates) {
    if (selectedDates.length === 2) {
      // Les valeurs sont déjà au format "Y-m-d" compatible avec new Date()
      this.startInputTarget.value = selectedDates[0].toISOString().split('T')[0];
      this.endInputTarget.value = selectedDates[1].toISOString().split('T')[0];

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
      this.startInputTarget.value = selectedDates[0].toISOString().split('T')[0];
      this.endInputTarget.value = selectedDates[1].toISOString().split('T')[0];
    }
  }
}
