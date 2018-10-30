#= require active_admin/base
//= require chosen-jquery

$ ->
  $('.chosen-select').chosen
    placeholder_text: 'Select Users'
    no_results_text: 'No results matched'
    width: "250px"
