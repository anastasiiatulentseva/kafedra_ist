do ->
  init_enable_fields_for_students = ->
    return unless $('#select_user_roles').length

    if $('#select_user_roles').val() is 'students'
      $('.select-group')[0].selectize.enable()
      $('.select-specialty')[0].selectize.enable()
      $('.select-course')[0].selectize.enable()
    else
      $('.select-group')[0].selectize.disable()
      $('.select-course')[0].selectize.disable()
      $('.select-specialty')[0].selectize.disable()

    $('#select_user_roles').change ->
      if $(this).val() is 'students'
        $('.select-group')[0].selectize.enable()
        $('.select-specialty')[0].selectize.enable()
        $('.select-course')[0].selectize.enable()
      else
        $('.select-group')[0].selectize.disable()
        $('.select-course')[0].selectize.disable()
        $('.select-specialty')[0].selectize.disable()

  init_selectize_fields_for_students = ->
    $('.for-students').selectize maxItems: 5

  $(document).on 'turbolinks:load', ->
    init_selectize_fields_for_students()
    init_enable_fields_for_students()
