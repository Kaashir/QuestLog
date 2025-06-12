// app/javascript/controllers/confirm_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = {
    url: String,
    method: String,
    message: String
  }

  connect() {
    this.modal = document.getElementById("confirmModal")
    this.messageElement = document.getElementById("confirmMessage")
    this.confirmButton = document.getElementById("confirmAction")
    this.cancelButton = document.getElementById("cancelConfirm")

    // Bind click handlers (important!)
    this.confirmButton?.addEventListener("click", () => this.perform())
    this.cancelButton?.addEventListener("click", () => this.hide())
  }

  show(event) {
    event.preventDefault()
    this.messageElement.textContent = this.messageValue
    this.modal.classList.add("show")
    this.modal.style.display = "block"
    document.body.classList.add("modal-open")
  }

  hide() {
    this.modal.classList.remove("show")
    this.modal.style.display = "none"
    document.body.classList.remove("modal-open")
  }

  perform() {
    fetch(this.urlValue, {
      method: this.methodValue.toUpperCase(),
      headers: {
        "Accept": "text/vnd.turbo-stream.html",
        "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').content
      }
    }).then(() => this.hide())
  }
}
