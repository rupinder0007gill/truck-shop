import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="invoice-nested-form"
export default class extends Controller {
  static targets = ['selectProduct', 'productQuantity', 'productPrice', 'productFinalPrice', 'orderPrice', 'orderTax', 'orderDiscount', 'orderTotalPrice', 'productDestroy', 'serviceName', 'servicePrice', 'serviceDestroy'];

  connect() {
    console.log("connect");

  }

  remove(event) {
    event.preventDefault();
    super.remove(event);
    this.change();
  }

  change() {
    console.log("hello");
    var orderTotal = 0;
    this.selectProductTargets.forEach((element, index) => {
      if(element.options[element.selectedIndex].dataset.price) {
        if(this.productDestroyTargets[index].value != 1) {
          this.productPriceTargets[index].value = element.options[element.selectedIndex].dataset.price;
          var productFinalPrice = element.options[element.selectedIndex].dataset.price * this.productQuantityTargets[index].value;
          this.productFinalPriceTargets[index].value = productFinalPrice;

          orderTotal = orderTotal + productFinalPrice;
        }
      }
    });
    this.servicePriceTargets.forEach((element, index) => {
      if(this.serviceDestroyTargets[index].value != 1) {
        var servicePrice = this.servicePriceTargets[index].value;

        orderTotal = parseFloat(orderTotal) + parseFloat(servicePrice);
      }
    })

    this.orderPriceTarget.value = parseFloat(orderTotal);
    this.orderTotalPriceTarget.value = parseFloat(orderTotal) + parseFloat(this.orderTaxTarget.value) - parseFloat(this.orderDiscountTarget.value);
  }
}
