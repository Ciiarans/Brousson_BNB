import { Controller } from "@hotwired/stimulus";
import flatpickr from "flatpickr";

// Connects to data-controller="datepicker"
export default class extends Controller {
  static targets = ["startInput", "endInput"];
  static values = { reservedRanges: Array };

  connect() {

    this.initFlatpickr();
  }

  initFlatpickr() {
    const options = {
      dateFormat: "d-m-Y",
      mode: "range",
      minDate: "today",
      longhandCurrentMonth: true,
      disable: this.reservedRangesValue,
      onChange: this.handleDateChange.bind(this),
      locale: {
        firstDayOfWeek: 1,
        weekdays: {
          shorthand: ['Dim', 'Lun', 'Mar', 'Mer', 'Jeu', 'Ven', 'Sam'],
          longhand: ['Dimanche', 'Lundi', 'Mardi', 'Mercredi', 'Jeudi', 'Vendredi', 'Samedi'],
        },
        months: {
          shorthand: ['Jan', 'Fév', 'Mar', 'Avr', 'Mai', 'Juin', 'Juil', 'Août', 'Sep', 'Oct', 'Nov', 'Déc'],
          longhand: ['Janvier', 'Février', 'Mars', 'Avril', 'Mai', 'Juin', 'Juillet', 'Août', 'Septembre', 'Octobre', 'Novembre', 'Décembre'],
        },
      },
    };
    console.log("Dates désactivées pour Flatpickr :", this.reservedRangesValue);
    flatpickr(this.startInputTarget, options);
    flatpickr(this.endInputTarget, options);
  }

  formatReservedRanges(reservedRanges) {
    // Formate les plages réservées pour le format attendu par Flatpickr
    return reservedRanges.map(range => {
      return { from: range.from, to: range.to }; // Assurez-vous que 'from' et 'to' existent
    });
  }

  handleDateChange(selectedDates) {
    if (selectedDates.length === 2) {
      const startDate = selectedDates[0].toLocaleDateString();
      const endDate = selectedDates[1].toLocaleDateString();
      console.log("Start date:", startDate);
      console.log("End date:", endDate);

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
      const startDate = selectedDates[0].toLocaleDateString();
      const endDate = selectedDates[1].toLocaleDateString();

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
