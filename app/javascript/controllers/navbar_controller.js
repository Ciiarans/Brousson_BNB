// app/javascript/controllers/navbar_controller.js
import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["navbar"]

  connect() {
    this.lastScrollTop = 0;
    window.addEventListener("scroll", this.handleScroll.bind(this));
  }

  disconnect() {
    window.removeEventListener("scroll", this.handleScroll.bind(this));
  }

  handleScroll() {
    const scrollTop = window.pageYOffset || document.documentElement.scrollTop;

        // Ajouter ou retirer la classe 'scrolled' selon la position du scroll
        if (scrollTop > 50) {
          this.navbarTarget.classList.add("scrolled");
          const btn = document.getElementById("dropdownMenuButton1"); // Assurez-vous que votre bouton a l'ID "btn"
          btn.classList.add("btn-outline-primary");
          btn.classList.remove("btn-outline-light");
        } else {
          this.navbarTarget.classList.remove("scrolled");
          const btn = document.getElementById("dropdownMenuButton1");
          btn.classList.remove("btn-outline-primary");
          btn.classList.add("btn-outline-light");
        }

        if (scrollTop > this.lastScrollTop) {
          // Scroll vers le bas, on cache la navbar
          this.navbarTarget.classList.remove("navbar-visible");
        } else {
          // Scroll vers le haut, on affiche la navbar
          this.navbarTarget.classList.add("navbar-visible");
        }

        this.lastScrollTop = scrollTop;
      }
}
