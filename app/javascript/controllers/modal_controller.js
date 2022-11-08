import { Controller } from "@hotwired/stimulus";
import { application } from "./application";

export const toggleModal = window.toggleModal = (id, event) => {
  if (event) event.preventDefault();

  const element = document.getElementById(id);
  if (!element) return;

  const modalController = application.getControllerForElementAndIdentifier(element, "modal");
  if (modalController) modalController.toggle();
};

// Connects to data-controller="modal"
export default class extends Controller {
  toggle() {
    this.element.classList.toggle("hidden");
  }
}
