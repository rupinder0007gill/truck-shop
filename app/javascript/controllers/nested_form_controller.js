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
