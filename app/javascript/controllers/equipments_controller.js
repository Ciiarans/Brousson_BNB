import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["list"];

  add(event) {
    const category = event.target.previousElementSibling.name.split('_')[2];
    const newEquipmentInput = event.target.previousElementSibling;
    const newEquipmentValue = newEquipmentInput.value.trim();

    if (newEquipmentValue) {
      const equipmentDiv = document.createElement("div");
      equipmentDiv.innerHTML = `
        <input type="checkbox" name="property[equipments][]" value="${newEquipmentValue}" class="form-check-input" checked>
        <label class="form-check-label">${newEquipmentValue}</label>
      `;
      this.listTarget.appendChild(equipmentDiv);
      newEquipmentInput.value = ""; // Clear the input after adding
    }
  }
}
