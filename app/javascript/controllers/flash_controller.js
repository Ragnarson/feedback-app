import { Controller } from "@hotwired/stimulus";
import { application } from "./application";

export const showFlashMessage = (type, message) => {
  const element = document.getElementById(`flash-${type}`);
  if (!element) return;

  const flashController = application.getControllerForElementAndIdentifier(element, "flash");
  if (flashController) flashController.show({ params: { message } });
}

// Connects to data-controller="flash"
export default class extends Controller {
  static targets = ["message"];

  close() {
    this.element.classList.add("hidden");
  }

  show({ params }) {
    if (params.message) this.messageTarget.innerHTML = params.message;
    this.element.classList.remove("hidden");
  }
}