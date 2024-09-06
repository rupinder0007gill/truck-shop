// This file is auto-generated by ./bin/rails stimulus:manifest:update
// Run that command whenever you add a new controller or create them with
// ./bin/rails generate stimulus controllerName

import { application } from "./application"

import CustomerModalController from "./customer_modal_controller"
application.register("customer-modal", CustomerModalController)

import CustomersAutocompleteController from "./customers_autocomplete_controller"
application.register("customers-autocomplete", CustomersAutocompleteController)

import FlatpickerController from "./flatpicker_controller"
application.register("flatpicker", FlatpickerController)

import HelloController from "./hello_controller"
application.register("hello", HelloController)

import InvoiceNestedFormController from "./invoice_nested_form_controller"
application.register("invoice-nested-form", InvoiceNestedFormController)

import NestedFormController from "./nested_form_controller"
application.register("nested-form", NestedFormController)

import RejectPartsModalController from "./reject_parts_modal_controller"
application.register("reject-parts-modal", RejectPartsModalController)

import SearchFormController from "./search_form_controller"
application.register("search-form", SearchFormController)

import VehicleModalController from "./vehicle_modal_controller"
application.register("vehicle-modal", VehicleModalController)
