import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="invoice-nested-form"
export default class extends Controller {
  static targets = ['hourlyRate', 'selectType', 'selectProduct', 'itemDescription', 'itemQuantity', 'itemPrice', 'itemFinalPrice', 'orderPrice', 'orderTax', 'orderDiscount', 'orderTotalPrice', 'itemDestroy'];

  connect() {
    console.log("connect");
  }

  change() {
    console.log("invoice hello");
    var orderTotal = 0;
    this.selectTypeTargets.forEach((element, index) => {
      console.log('thisssssss', this);
      if(element.value == 'product') {
        this.selectProductTargets[index].classList.remove('d-none')
        this.itemDescriptionTargets[index].classList.add('d-none')
        var selectedProduct = this.selectProductTargets[index];
        if(selectedProduct.options[selectedProduct.selectedIndex].dataset.price) {
          if(this.itemDestroyTargets[index].value != 1) {
            this.itemPriceTargets[index].value = selectedProduct.options[selectedProduct.selectedIndex].dataset.price;
            var itemFinalPrice = selectedProduct.options[selectedProduct.selectedIndex].dataset.price * this.itemQuantityTargets[index].value;
            this.itemFinalPriceTargets[index].value = itemFinalPrice;

            orderTotal = orderTotal + itemFinalPrice;
          }
        }
      } else if(element.value == 'labour') {
        this.selectProductTargets[index].classList.add('d-none')
        this.itemDescriptionTargets[index].classList.remove('d-none')
        if(this.itemDestroyTargets[index].value != 1) {
          this.itemPriceTargets[index].value = this.hourlyRateTargets[index].value;
          var itemFinalPrice = this.hourlyRateTargets[index].value * this.itemQuantityTargets[index].value;
          this.itemFinalPriceTargets[index].value = itemFinalPrice;

          orderTotal = orderTotal + itemFinalPrice;
        }
      }
    });

    this.orderPriceTarget.value = parseFloat(orderTotal);
    this.orderTotalPriceTarget.value = parseFloat(orderTotal) + parseFloat(this.orderTaxTarget.value) - parseFloat(this.orderDiscountTarget.value);
  }
}
