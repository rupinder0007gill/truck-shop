import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="customers-autocomplete"
export default class extends Controller {
  static targets = [ "customerEmail", "customerId", "customerName", "customerPhone", "searchURL" ]

  connect() {
    this.addressAutocomplete(document.getElementById("autocomplete-container"), (data) => {
      this.customerIdTarget.value = data.id;
      this.customerNameTarget.value = data.first_name + ' ' + data.last_name;
      this.customerPhoneTarget.value = data.phone;
    });
  }

  /* 
    The addressAutocomplete takes a container element (div) as a parameter
  */
  addressAutocomplete(containerElement, callback) {
    // find input element
    var inputElement = document.getElementById("autocomplete-field");
    var searchURL = document.getElementById("searchURL");

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

        var url = searchURL.value + '?email_search=' + currentValue;

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
        data.forEach((customer, index) => {
          /* Create a DIV element for each element: */
          var itemElement = document.createElement("DIV");
          /* Set formatted address as item value */
          itemElement.innerHTML = customer.email;

          /* Set the value for the autocomplete text field and notify: */
          itemElement.addEventListener("click", function(e) {
            inputElement.value = currentItems[index].email;
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
