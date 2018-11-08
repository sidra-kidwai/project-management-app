@addTimeLogValidation = ->
  $('#datepicker-start').datetimepicker format: 'YYYY-MM-DD HH:mm:ss Z'
  $('#datepicker-end').datetimepicker
    useCurrent: false
    format: 'YYYY-MM-DD HH:mm:ss Z'
  $('#datepicker-start').on 'dp.change', (e) ->
    $('#datepicker-end').data('DateTimePicker').minDate e.date
    return
  $('#datepicker-end').on 'dp.change', (e) ->
    $('#datepicker-start').data('DateTimePicker').maxDate e.date
    return
  return

