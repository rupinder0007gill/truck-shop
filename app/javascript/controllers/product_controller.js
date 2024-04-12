import { Controller } from "@hotwired/stimulus"
import flatpickr from "flatpickr";

// Connects to data-controller="product"
export default class extends Controller {
  static targets = ["form", "price", "discount_percentage", "selling_price", "final_price"];

  connect() {
    console.log('connected');
    flatpickr('.release_date');
    this.priceTarget.addEventListener("change", this.caculatePrice.bind(this));
    this.discount_percentageTarget.addEventListener("change", this.caculatePrice.bind(this));
  }

  async caculatePrice() {
    var price = this.priceTarget.value;
    var discount_percentage = this.discount_percentageTarget.value;
    var discount_price = 0;
    if(price && discount_percentage) {
      discount_price = (price * discount_percentage) / 100;
    }
    var selling_price = price - discount_price;
    this.selling_priceTarget.value = selling_price;
    this.final_priceTarget.value = selling_price;
  }
}
