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

    this.cancelButton.addEventListener("click", () => this.hideModal())
  }

  show(event) {
  event.preventDefault()

  this.messageElement.textContent = this.messageValue
  this.modal.classList.add("show")
  this.modal.style.display = "block"
  document.body.classList.add("modal-open")

  // Remove any previous listener by replacing the button
  const newButton = this.confirmButton.cloneNode(true)
  this.confirmButton.replaceWith(newButton)
  this.confirmButton = newButton

  this.confirmButton.addEventListener("click", () => {
    fetch(this.urlValue, {
      method: this.methodValue.toUpperCase(),
      headers: {
        "Accept": "text/vnd.turbo-stream.html",
        "X-CSRF-Token": document.querySelector("meta[name=csrf-token]").content
      }
    })
    .then(response => {
      if (response.ok) {
        return response.text()
      } else {
        throw new Error("Turbo Stream request failed.")
      }
    })
    .then(html => {
      const template = document.createElement("template")
      template.innerHTML = html.trim()
      const streams = template.content.querySelectorAll("turbo-stream")
      streams.forEach(el => document.body.appendChild(el))
    })
    .then(() => this.hideModal())
    .catch(error => console.error(error))
  }, { once: true })
}


  hideModal() {
    this.modal.classList.remove("show")
    this.modal.style.display = "none"
    document.querySelector('.modal-backdrop')?.remove()
    document.body.classList.remove("modal-open")
  }
}

