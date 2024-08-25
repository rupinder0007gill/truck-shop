import { Controller } from "@hotwired/stimulus"
import NestedForm from '@stimulus-components/rails-nested-form'

// Connects to data-controller="invoice-nested-form"
export default class extends Controller {
  static targets = ['hourlyRate', 'selectType', 'selectProduct', 'itemDescription', 'itemQuantity', 'itemPrice', 'itemFinalPrice', 'orderPrice', 'orderTax', 'taxPercentage', 'orderDiscount', 'orderTotalPrice', 'itemDestroy', 'invoiceItems'];

  connect() {
    console.log("connect");
    this.nestedForm = new NestedForm(this.element);
    this.change();
  }

  change() {
    var orderTotal = 0;
    this.selectTypeTargets.forEach((element, index) => {
      console.log('thisssssss', this);
      // Find the <tr> element containing the changed <select>
      const trElement = element.closest('tr');
      // Get all <td> elements within this <tr>
      const tdElements = trElement.querySelectorAll('td');

      // Find the second <td> element (index 1)
      const secondTd = tdElements[1];
      
      // Access the <select> and <text_field> within the second <td>
      const selectProduct = secondTd.querySelector('select');
      const textFieldDescription = secondTd.querySelector('input[type="text"]');

      if(this.itemDestroyTargets[index].value != 1) {
        if(element.value == 'product') {
          selectProduct.classList.remove('d-none')
          textFieldDescription.classList.add('d-none')
          var selectedProduct = this.selectProductTargets[index];
          if(selectedProduct.options[selectedProduct.selectedIndex].dataset.price) {
            this.itemPriceTargets[index].value = selectedProduct.options[selectedProduct.selectedIndex].dataset.price;
            var itemFinalPrice = selectedProduct.options[selectedProduct.selectedIndex].dataset.price * this.itemQuantityTargets[index].value;
            this.itemFinalPriceTargets[index].value = itemFinalPrice;

            orderTotal = orderTotal + itemFinalPrice;
          }
        } else if(element.value == 'labour') {
          selectProduct.classList.add('d-none')
          textFieldDescription.classList.remove('d-none')
          this.itemPriceTargets[index].value = this.hourlyRateTarget.value;
          var itemFinalPrice = this.hourlyRateTarget.value * this.itemQuantityTargets[index].value;
          this.itemFinalPriceTargets[index].value = itemFinalPrice;

          orderTotal = orderTotal + itemFinalPrice;
        } else if(element.value == 'core_product') {
          if (selectProduct) {
            selectProduct.classList.add('d-none')
          }
          if (textFieldDescription) {
            textFieldDescription.classList.remove('d-none')
          }
          var itemFinalPrice = this.itemPriceTargets[index].value * this.itemQuantityTargets[index].value;
          this.itemFinalPriceTargets[index].value = itemFinalPrice;

          orderTotal = orderTotal + itemFinalPrice;
        }
      }
    });

    var tax_amount = (this.taxPercentageTarget.value * parseFloat(orderTotal))/100;
    this.orderTaxTarget.value = parseFloat(tax_amount);

    this.orderPriceTarget.value = parseFloat(orderTotal);
    this.orderTotalPriceTarget.value = parseFloat(orderTotal) + parseFloat(this.orderTaxTarget.value) - parseFloat(this.orderDiscountTarget.value);
  }

  check_core_price(event) {
    console.log("invoice hello");
    var selectedProduct = event.target.options[event.target.selectedIndex]
    var corePrice = selectedProduct.dataset.corePrice;
    var name = selectedProduct.dataset.name;
    if (corePrice > 0) {
      if(confirm('Are we need to add core product?')){
        this.appendNewItem(corePrice, name);
      }
    }
    this.change();
  }

  appendNewItem(corePrice = 0, name = '') {
    const index = new Date().getTime(); // Unique index for each row

    const newItemRow = `
      <tr class="border-200 nested-form-wrapper" data-new-record="true">
        <td class="align-middle">
          <select name="invoice[invoice_items_attributes][${index}][invoice_type]" class="form-select" data-action="change->invoice-nested-form#change" data-invoice-nested-form-target="selectType" readonly>
            <option value="product">Product</option>
            <option value="labour">Labour</option>
            <option value="core_product" selected>Core product</option>
          </select>
        </td>
        <td class="align-middle">
          <input type="text" name="invoice[invoice_items_attributes][${index}][description]" value="Core price of ${name}" class="form-control" data-action="change->invoice-nested-form#change" data-invoice-nested-form-target="itemDescription">
        </td>
        <td class="align-middle text-center">
          <input type="number" name="invoice[invoice_items_attributes][${index}][qty]" value="1" class="form-control" data-action="change->invoice-nested-form#change" data-invoice-nested-form-target="itemQuantity" step="0.5">
        </td>
        <td class="align-middle text-center">
          <input type="number" name="invoice[invoice_items_attributes][${index}][price]" value="-${corePrice}" class="form-control" data-action="change->invoice-nested-form#change" data-invoice-nested-form-target="itemPrice">
        </td>
        <td class="align-middle text-center">
          <input type="number" name="invoice[invoice_items_attributes][${index}][final_price]" class="form-control" data-action="change->invoice-nested-form#change" data-invoice-nested-form-target="itemFinalPrice">
        </td>
        <td class="align-middle text-end">
          <button type="button" data-controller="nested-form" data-action="nested-form#triggerAction" class="btn btn-danger"><i class="fa-solid fa-trash"></i></button>
          <input type="hidden" name="invoice[invoice_items_attributes][${index}][_destroy]" value="false" data-invoice-nested-form-target="itemDestroy">
        </td>
      </tr>
    `;

    this.invoiceItemsTarget.insertAdjacentHTML("beforebegin", newItemRow);
    this.nestedForm.initialize(this.element);
  }
}
