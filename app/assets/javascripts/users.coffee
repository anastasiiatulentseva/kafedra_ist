do ->
  init_selectized_roles_dropdown = ->
    $('.select-role').selectize maxItems: 3
  init_form_auto_submit = ->
    $('select.select-role').change ->
      $(this).closest("form").submit()
  init_delete_user_button = ->
    $('.delete-user').bind 'ajax:success', ->
      $(this).closest('tr').fadeOut()

  $(document).on 'turbolinks:load', ->
    init_selectized_roles_dropdown()
    init_form_auto_submit()
    init_delete_user_button()
