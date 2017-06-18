save_form = ->
  if ($('#order_client_id').val() == "- Создание нового -")
    $('#order_client_id').remove()
    $('#order_client_attributes_id').remove()
  else if ($('#order_client_id').val() == '- Редактирование -')
    $('#order_client_id').remove()

insert_form = ->
  f = $("#client-fieldset").attr("data-content")
  if ($("#order_client_id").val() == '')
    $("#client-fields").html('Без клиента')
  else if ($('#order_client_id').val() == '- Создание нового -')
    $("#client-fields").html(f)
  else if ($('#order_client_id').val() == '- Редактирование -')
    $("#client-fields").html(f)
  else
    $("#client-fields").html('Выбран существующий клиент')

ready = ->
  insert_form()
  $("#order_client_id").change -> insert_form()
  $('#save').on 'click', save_form

$(document).ready ready
$(document).on 'page:load', ready
