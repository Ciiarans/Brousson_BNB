// app/javascript/controllers/navbar_controller.js
import { Controller } from "@hotwired/stimulus";

const LOGOS = {
  blue: "texte-logo_eprlpa",
  white: "logo-blanc_ynmgli",
  whiteSmall: "logo-blanc-st_lfsacg",
  blueSmall: "logo-bleu-st_bkrb3i",
  blueComplete: "logo-bleu_d1bth1",
  whiteComplete: "logo-complet_fke80k",
};

export default class extends Controller {
  static targets = ["navbar", "logo"];

  connect() {
    this.lastScrollTop = 0;
    window.addEventListener("scroll", this.handleScroll.bind(this));
    window.addEventListener("resize", this.updateLogo.bind(this)); // Mettre à jour le logo lors du redimensionnement
    this.updateLogo(); // Met à jour le logo lors de la première connexion
  }

  disconnect() {
    window.removeEventListener("scroll", this.handleScroll.bind(this));
    window.removeEventListener("resize", this.updateLogo.bind(this));
  }

  // Cette méthode met à jour le logo en fonction de la taille de l'écran
  updateLogo() {
    const mediaQuery = window.matchMedia("(max-width: 768px)");
    const logoId = mediaQuery.matches ? LOGOS.blueSmall : LOGOS.blue;
    this.logoTarget.src = this.buildCloudinaryUrl(logoId);
  }

  // Cette méthode génère l'URL de Cloudinary pour le logo en utilisant le public ID
  buildCloudinaryUrl(publicId) {
    return `https://res.cloudinary.com/dqdlonijq/image/upload/${publicId}.svg`;
  }

  handleScroll() {
    const scrollTop = window.scrollY || document.documentElement.scrollTop;

    // Ajouter ou retirer la classe 'scrolled' selon la position du scroll
    if (scrollTop > 30) {
      this.navbarTarget.classList.add("scrolled");
    } else {
      this.navbarTarget.classList.remove("scrolled");
    }

    // Masquer ou afficher la navbar en fonction du sens du scroll
    if (scrollTop > this.lastScrollTop) {
      this.navbarTarget.classList.remove("navbar-visible");
    } else {
      this.navbarTarget.classList.add("navbar-visible");
    }

    this.lastScrollTop = scrollTop;
  }
}
