do ->
  init_contact_user_modal = ->
    $('a.contact-user-link').on 'click', (e) ->
      e.preventDefault()

      modalUrl = $(this).attr('href')
      $.get modalUrl, (modalContent) ->
        $('#contact_user_modal .modal-dialog').html(modalContent)
        $('#contact_user_modal').modal('show')

  $(document).on 'turbolinks:load', ->
    init_contact_user_modal()
