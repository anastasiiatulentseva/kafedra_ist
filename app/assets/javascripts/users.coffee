do ->
  $(document).on 'turbolinks:load', ->
    $('.select-role').selectize maxItems: 3
    $("select.select-role").change ->
      $(this).closest("form").submit()
    $('.delete-user').bind 'ajax:success', ->
      $(this).closest('tr').fadeOut()
