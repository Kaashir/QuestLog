import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["dropdown"]

  connect() {
    console.log("hey there")
  }
  toggle() {
    this.dropdownTarget.classList.toggle("d-none")
  }
}
