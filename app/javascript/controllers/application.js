import { Application } from "@hotwired/stimulus"

// import "./transitions";
// import "./ui";

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }
