import { Controller } from "@hotwired/stimulus"
import { Modal } from "bootstrap"

// Connects to data-controller="modal"
export default class extends Controller {
  static targets = ["modal", "form"]

  connect() {
    console.log('modal connect')
    this.modal = new Modal(this.modalTarget)
  }

  open() {
    console.log('modal open')
    this.modal.show()
  }

  close() {
    console.log('modal close')
    this.modal.hide()
  }

  async submit(event) {
    event.preventDefault()

    const formData = new FormData(this.formTarget)
    const response = await fetch(this.formTarget.action, {
      method: 'POST',
      body: formData,
      headers: {
        'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').getAttribute('content')
      }
    })

    if (response.ok) {
      const turboStream = await response.text()
      Turbo.renderStreamMessage(turboStream)
      this.close()
    } else {
      console.error('Form submission failed')
    }
  }
}
