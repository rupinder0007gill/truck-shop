import { Controller } from "@hotwired/stimulus"
import { Modal } from "bootstrap";

// Connects to data-controller="vehicle-modal"
export default class extends Controller {
  static targets = ["vehicleModal", "form", "addVehicleURL", "vehicleId", "vehicleVIN", "vehicleMakeModel", "vehicleUnitNumber", "vehicleYear", "vehicleOdoMeter", "vehicleLicenceNumber", "vehiclePoNumber", "vehicleSearchURL", "invoiceVehicleVIN", "invoiceVehicleMakeModel", "invoiceVehicleUnitNumber", "invoiceVehicleYear", "invoiceVehicleOdometer", "invoiceVehicleLicenceNumber", "invoiceVehiclePoNumber" ]
  
  connect() {
    this.modal = new Modal(this.vehicleModalTarget);
    this.addressAutocomplete(document.getElementById("vehicle-autocomplete-container"), (data) => {
      this.vehicleIdTarget.value = data.id;
      this.vehicleVINTarget.value = data.vin;
      this.vehicleMakeModelTarget.value = data.make_model;
      this.vehicleUnitNumberTarget.value = data.unit_number;
      this.vehicleYearTarget.value = data.year;
      this.vehicleLicenceNumberTarget.value = data.licence_number;
      this.vehiclePoNumberTarget.value = data.po_number;
    });
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
    this.vehicleVINTarget.value = ''
    this.vehicleMakeModelTarget.value = ''
    this.vehicleUnitNumberTarget.value = ''
    this.vehicleYearTarget.value = ''
    this.vehicleLicenceNumberTarget.value = ''
    this.vehiclePoNumberTarget.value = ''
    this.vehicleOdoMeterTarget.value = ''
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

  /* 
    The addressAutocomplete takes a container element (div) as a parameter
  */
  addressAutocomplete(containerElement, callback) {
    // find input element
    var inputElement = document.getElementById("vehicle-autocomplete-field");
    var searchURL = document.getElementById("vehicleSearchURL");

    /* Active request promise reject function. To be able to cancel the promise when a new request comes */
    var currentPromiseReject;

    /* Current autocomplete items data (GeoJSON.Feature) */
    var currentItems;

    /* Execute a function when someone writes in the text field: */
    inputElement.addEventListener("input", function(e) {
      /* Close any already open dropdown list */
      closeDropDownList(containerElement);

      var currentValue = this.value;

      // Cancel previous request promise
      if (currentPromiseReject) {
        currentPromiseReject({
          canceled: true
        });
      }

      if (!currentValue) {
        return false;
      }

      /* Create a new promise and send geocoding request */
      var promise = new Promise((resolve, reject) => {
        currentPromiseReject = reject;

        var url = searchURL.value + '?vin_search=' + currentValue;

        fetch(url)
          .then(response => {
            // check if the call was successful
            if (response.ok) {
              response.json().then(data => resolve(data));
            } else {
              response.json().then(data => reject(data));
            }
          });
      });

      promise.then((data) => {
        console.log('dataaaa', data)
        currentItems = data;

        /*create a DIV element that will contain the items (values):*/
        var autocompleteItemsElement = document.createElement("div");
        autocompleteItemsElement.setAttribute("class", "autocomplete-items");
        containerElement.appendChild(autocompleteItemsElement);

        /* For each item in the results */
        data.forEach((vehicle, index) => {
          /* Create a DIV element for each element: */
          var itemElement = document.createElement("DIV");
          /* Set formatted address as item value */
          itemElement.innerHTML = vehicle.vin;

          /* Set the value for the autocomplete text field and notify: */
          itemElement.addEventListener("click", function(e) {
            inputElement.value = currentItems[index].vin;
            callback(currentItems[index]);
            /* Close the list of autocompleted values: */
            closeDropDownList(containerElement);
          });

          autocompleteItemsElement.appendChild(itemElement);
        });
      }, (err) => {
        if (!err.canceled) {
          console.log(err);
        }
      });
    });
  }
}

function closeDropDownList(containerElement) {
  var autocompleteItemsElement = containerElement.querySelector(".autocomplete-items");
  if (autocompleteItemsElement) {
    containerElement.removeChild(autocompleteItemsElement);
  }
}
