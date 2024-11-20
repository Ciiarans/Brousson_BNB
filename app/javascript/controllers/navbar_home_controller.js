// app/javascript/controllers/logo_controller.js

import { Controller } from "@hotwired/stimulus";
import { LOGOS } from "../config";

export default class extends Controller {
  static targets = ["logo", "navbar"];

  initialize() {
    this.updateLogo(); // Met à jour le logo lors de l'initialisation
  }

  connect() {
    window.addEventListener("scroll", this.handleScroll.bind(this));
    window.addEventListener("resize", this.updateLogo.bind(this)); // Met à jour le logo sur redimensionnement
  }

  disconnect() {
    window.removeEventListener("scroll", this.handleScroll.bind(this));
    window.removeEventListener("resize", this.updateLogo.bind(this));
  }

  updateLogo() {
    const mediaQuery = window.matchMedia("(max-width: 768px)");

    // Met à jour le logo selon la largeur de l'écran
    const logoId = mediaQuery.matches ? LOGOS.whiteSmall : LOGOS.white;
    this.logoTarget.src = this.buildCloudinaryUrl(logoId);
  }

  handleScroll() {
    const scrollTop = window.scrollY || document.documentElement.scrollTop;
    const mediaQuery = window.matchMedia("(max-width: 768px)");

    if (scrollTop > 30) {
      // Ajoute la classe 'scrolled' au navbar
      this.navbarTarget.classList.add("scrolled");

      // Change le logo pour la version scrolée
      const logoId = mediaQuery.matches ? LOGOS.blueSmall : LOGOS.blue;
      this.logoTarget.src = this.buildCloudinaryUrl(logoId);
    } else {
      // Retire la classe 'scrolled' au navbar
      this.navbarTarget.classList.remove("scrolled");

      // Change le logo pour la version par défaut
      const logoId = mediaQuery.matches ? LOGOS.whiteSmall : LOGOS.white;
      this.logoTarget.src = this.buildCloudinaryUrl(logoId);
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

  buildCloudinaryUrl(publicId) {
    return `https://res.cloudinary.com/dqdlonijq/image/upload/${publicId}.svg`;
  }
}
