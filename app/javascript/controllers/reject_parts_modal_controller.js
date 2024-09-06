import { Controller } from "@hotwired/stimulus"
import { Modal } from "bootstrap";

// Connects to data-controller="reject-parts-modal"
export default class extends Controller {
  static targets = ["rejectParts", "rejectComment" ]
  
  connect() {
    this.modal = new Modal(this.rejectPartsTarget);
  }

  open() {
    this.clearForm()
    this.modal.show();
  }

  close() {
    this.modal.hide();
  }

  clearForm() {
    // Reset form fields
    this.rejectCommentTarget.value = ''
  }

  async submit(event) {
    event.preventDefault()

    const url = this.addVehicleURLTarget.value + '?vin=' + this.vehicleVINTarget.value + '&make_model=' + this.vehicleMakeModelTarget.value + '&unit_number=' + this.vehicleUnitNumberTarget.value + '&year=' + this.vehicleYearTarget.value + '&odometer=' + this.vehicleOdoMeterTarget.value + '&licence_number=' + this.vehicleLicenceNumberTarget.value + '&po_number=' + this.vehiclePoNumberTarget.value;

    const response = await fetch(url, {
      method: 'GET'
    })

    if (response.ok) {
      const data = await response.json() // or response.text() for HTML
      this.handleResponse(data)
    } else {
      console.error('Failed to fetch data')
      const data = await response.json() // or response.text() for HTML
      alert(data.join('\n'))
    }
  }

  handleResponse(data) {
    // Process the response data here
    // For example, update a target element with the data
    this.vehicleIdTarget.value = data.id
    this.invoiceVehicleVINTarget.value = data.vin
    this.invoiceVehicleMakeModelTarget.value = data.make_model
    this.invoiceVehicleUnitNumberTarget.value = data.unit_number
    this.invoiceVehicleYearTarget.value = data.year
    this.invoiceVehicleOdometerTarget.value = this.vehicleOdoMeterTarget.value
    this.invoiceVehicleLicenceNumberTarget.value = data.licence_number
    this.invoiceVehiclePoNumberTarget.value = data.po_number
    this.close()
  }
}
