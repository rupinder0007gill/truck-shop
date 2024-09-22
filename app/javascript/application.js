// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"

import * as moment from 'moment';
window.moment = moment;

import { detectOverflow } from '@popperjs/core';
import * as bootstrap from "bootstrap";

import "trix"
import "@rails/actiontext"

// Sub directory
import './src/plugins'
import './src/theme'

document.addEventListener('turbo:load', function () {
  $('.menu-taggle').click(function() {
    $('nav').toggleClass('active')
  });
  var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'))
  var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
    return new bootstrap.Tooltip(tooltipTriggerEl)
  })
  flatpickr(".date-range-picker", {});
});
