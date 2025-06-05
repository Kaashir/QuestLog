import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["start", "sessionForm"]
  static values = {
    userPresent: Boolean,
    username: String
  }

  connect() {
    console.log("Welcome controller connected", {
      userPresent: this.userPresentValue,
      username: this.usernameValue
    })

    // Check if user just logged in using URL parameter
    const urlParams = new URLSearchParams(window.location.search)
    if (urlParams.has('just_logged_in') && this.userPresentValue) {
      // Small delay to ensure everything is loaded
      setTimeout(() => this.start(), 500)
    }
  }

  start() {
    if (this.userPresentValue) {
      this.showWelcomeMessage()
    } else {
      this.showLoginForm()
    }
  }

  showWelcomeMessage() {
    const button = this.startTarget
    button.textContent = ''
    const typewriter = document.createElement("span")
    typewriter.classList.add("typewriter-text")
    button.appendChild(typewriter)

    const name = this.usernameValue || 'User'
    const capitalizedName = name.charAt(0).toUpperCase() + name.slice(1).toLowerCase()
    const message = `Welcome ${capitalizedName}`
    let charIndex = 0

    const typeChar = () => {
      if (charIndex < message.length) {
        typewriter.textContent += message.charAt(charIndex)
        charIndex++
        setTimeout(typeChar, 100)
      } else {
        setTimeout(() => {
          window.location.href = "/user_quests"
        }, 1700)
      }
    }

    typeChar()
  }

  async showLoginForm() {
    this.startTarget.remove()
    const response = await fetch("/users/sign_in", {
      headers: { "Accept": "text/html" }
    })
    const html = await response.text()

    const wrapper = document.createElement("div")
    wrapper.classList.add("slide-up")
    wrapper.innerHTML = html
    this.sessionFormTarget.appendChild(wrapper)

    requestAnimationFrame(() => {
      wrapper.classList.add("show")
    })
  }
}
