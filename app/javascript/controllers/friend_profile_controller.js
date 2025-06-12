import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["modal"]

  connect() {
    this.element.addEventListener('click', this.handleClick.bind(this))
  }

  handleClick(event) {
    const friendId = event.currentTarget.dataset.friendId
    if (friendId) {
      fetch(`/friend_profile/${friendId}`)
        .then(response => response.text())
        .then(html => {
          const modalContent = document.querySelector('#friendprofileModal .modal-body')
          if (modalContent) {
            modalContent.innerHTML = html
          }
        })
    }
  }
}
