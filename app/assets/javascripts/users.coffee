do ->
  $(document).on 'turbolinks:load', ->
    $('.select-state').selectize maxItems: 3
    $("select.select-state").change ->
      $(this).closest("form").submit()
