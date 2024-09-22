import { Controller } from "@hotwired/stimulus"
import NestedForm from '@stimulus-components/rails-nested-form'

// Connects to data-controller="invoice-nested-form"
export default class extends Controller {
  static targets = ['hourlyRate', 'selectType', 'selectProduct', 'itemDescription', 'itemQuantity', 'itemPrice', 'itemFinalPrice', 'orderPrice', 'orderTax', 'taxPercentage', 'orderDiscount', 'orderTotalPrice', 'itemDestroy', 'invoiceItems', 'coreProduct'];

  connect() {
    console.log("connect");
    this.nestedForm = new NestedForm(this.element);
    //this.change();
  }

  change() {
    var orderTotal = 0;
    this.selectTypeTargets.forEach((element, index) => {
      // Find the <tr> element containing the changed <select>
      const trElement = element.closest('tr');
      // Get all <td> elements within this <tr>
      const tdElements = trElement.querySelectorAll('td');

      // Find the second <td> element (index 1)
      const secondTd = tdElements[1];
      
      // Access the <select> and <text_field> within the second <td>
      const selectProduct = secondTd.querySelector('select.product');
      const selectCoreProduct = secondTd.querySelector('select.core-product');
      const textFieldDescription = secondTd.querySelector('input[type="text"]');

      if(this.itemDestroyTargets[index].value != 1) {
        if(element.value == 'product') {
          selectProduct.classList.remove('d-none')
          selectCoreProduct.classList.add('d-none')
          textFieldDescription.classList.add('d-none')
          var selectedProduct = this.selectProductTargets[index];
          var selectedCoreProduct = this.coreProductTargets[index];
          selectedCoreProduct.selectedIndex = 0;
          if(selectedProduct.options[selectedProduct.selectedIndex].dataset.price) {
            this.itemPriceTargets[index].value = selectedProduct.options[selectedProduct.selectedIndex].dataset.price;
            var itemFinalPrice = selectedProduct.options[selectedProduct.selectedIndex].dataset.price * this.itemQuantityTargets[index].value;
            this.itemFinalPriceTargets[index].value = itemFinalPrice;

            orderTotal = orderTotal + itemFinalPrice;
          }
        } else if(element.value == 'labour') {
          selectProduct.classList.add('d-none')
          selectCoreProduct.classList.add('d-none')
          textFieldDescription.classList.remove('d-none')
          this.itemPriceTargets[index].value = this.hourlyRateTarget.value;
          var itemFinalPrice = this.hourlyRateTarget.value * this.itemQuantityTargets[index].value;
          this.itemFinalPriceTargets[index].value = itemFinalPrice;

          orderTotal = orderTotal + itemFinalPrice;
        } else if(element.value == 'core_product') {
          selectProduct.classList.add('d-none')
          textFieldDescription.classList.add('d-none')
          selectCoreProduct.classList.remove('d-none')

          var selectedCoreProduct = this.coreProductTargets[index];
          var selectedProduct = this.selectProductTargets[index];
          selectedProduct.selectedIndex = 0;
          if(selectedCoreProduct.options[selectedCoreProduct.selectedIndex].dataset.corePrice) {
            this.itemPriceTargets[index].value = -selectedCoreProduct.options[selectedCoreProduct.selectedIndex].dataset.corePrice;
            var itemFinalPrice = -selectedCoreProduct.options[selectedCoreProduct.selectedIndex].dataset.corePrice * this.itemQuantityTargets[index].value;
            this.itemFinalPriceTargets[index].value = itemFinalPrice;

            orderTotal = orderTotal + itemFinalPrice;
          }
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
    this.change();
    var selectedProduct = event.target.options[event.target.selectedIndex]
    var corePrice = selectedProduct.dataset.corePrice;
    var name = selectedProduct.dataset.name;
    if (corePrice > 0) {
      if(confirm('Do you need to add core product?')){
        this.appendNewItem(corePrice, name, event);
      }
    }
  }

  appendNewItem(corePrice = 0, name = '', event) {
    const index = new Date().getTime(); // Unique index for each row

    // Generate options from the existing selectProductTarget options
    let productOptionsHtml = '';
    Array.from(this.selectProductTarget.options).forEach((option, idx) => {
      if (idx == event.target.selectedIndex) {
        productOptionsHtml += `<option value="${option.value}" data-price="${option.dataset.price}" data-core-price="${option.dataset.corePrice}" data-name="${option.dataset.name}" selected>Core price of ${option.text}</option>`;
      } else {
        productOptionsHtml += `<option value="${option.value}" data-price="${option.dataset.price}" data-core-price="${option.dataset.corePrice}" data-name="${option.dataset.name}">Core price of ${option.text}</option>`;
      }
    });

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
          <select class="form-select product d-none" name="invoice[invoice_items_attributes][${index}][product_id]" id="invoice_invoice_items_attributes_${index}_product_id" data-action="change->invoice-nested-form#change" data-invoice-nested-form-target="selectProduct" }>
            ${productOptionsHtml}  <!-- Insert the options here -->
          </select>

          <select class="form-select core-product" data-invoice-nested-form-target="coreProduct" name="invoice[invoice_items_attributes][${index}][core_product_id]" id="invoice_invoice_items_attributes_${index}_core_product_id" data-action="change->invoice-nested-form#change" }>
            ${productOptionsHtml}  <!-- Insert the options here -->
          </select>

          <input type="text" name="invoice[invoice_items_attributes][${index}][description]" value="" class="form-control d-none" data-action="change->invoice-nested-form#change" data-invoice-nested-form-target="itemDescription">
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
