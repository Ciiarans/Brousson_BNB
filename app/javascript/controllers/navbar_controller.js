// app/javascript/controllers/navbar_controller.js
import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["navbar", "logo"]

  connect() {
    this.lastScrollTop = 0;
    window.addEventListener("scroll", this.handleScroll.bind(this));
  }

  disconnect() {
    window.removeEventListener("scroll", this.handleScroll.bind(this));
  }

  ChangeLogo() {
    const mediaQuery = window.matchMedia("(max-width: 768px)");
    if (mediaQuery.matches) {
      this.logoTarget.src = "/assets/logo-bleu-st.svg";
    } else {
      this.logoTarget.src = "/assets/texte-logo.svg";
    }
    console.log("ChangeLogo");
  }
  initialize() {
    this.ChangeLogo();
  }

  handleScroll() {
    const scrollTop = window.scrollY || document.documentElement.scrollTop;

        // Ajouter ou retirer la classe 'scrolled' selon la position du scroll
        if (scrollTop > 30) {
          this.navbarTarget.classList.add("scrolled");
        } else {
          this.navbarTarget.classList.remove("scrolled");
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
