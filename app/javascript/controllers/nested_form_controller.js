import NestedForm from '@stimulus-components/rails-nested-form'

export default class extends NestedForm {
  static targets = ['selectProduct', 'productQuantity', 'productPrice', 'productFinalPrice', 'orderPrice', 'orderTax', 'orderDiscount', 'orderTotalPrice', 'productDestroy'];

  connect() {
    super.connect()
  }

  remove(event) {
    event.preventDefault();
    super.remove(event);
    this.change();
  }

  invoiceRemove(event) {
    event.preventDefault();
    super.remove(event);
    this.element.dispatchEvent(new CustomEvent("messageFromChild", {
      detail: {
        message: "Hello from child"
      },
      bubbles: true   // This needs to be explicitly set to enable event bubbling
    }));
  }

  // Action method triggered by the button
  triggerAction(event) {
    // Find the parent controller instance
    const parentElement = this.element.closest('[data-controller="invoice-nested-form"]');
    console.log('dsfsdfdsf', parentElement)
    if (parentElement) {
      // Access the Stimulus application
      const application = this.application;

      // Get the parent controller instance
      const parentController = application.getControllerForElementAndIdentifier(parentElement, "invoice-nested-form");

      if (parentController) {
        // Call a method on the parent controller
        event.preventDefault();
        super.remove(event);
        parentController.change();
      } else {
        console.error("Parent controller instance not found.");
      }
    } else {
      console.error("Parent element with second-controller not found.");
    }
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
    })

    this.orderPriceTarget.value = parseFloat(orderTotal);
    this.orderTotalPriceTarget.value = parseFloat(orderTotal) + parseFloat(this.orderTaxTarget.value) - parseFloat(this.orderDiscountTarget.value);
  }
}
