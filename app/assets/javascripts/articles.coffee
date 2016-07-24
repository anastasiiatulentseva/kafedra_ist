do ->
  $(document).on 'turbolinks:load', ->
    window['rangy'].initilized = false
    $('.text-wysiwyg').wysihtml5({'toolbar': {'html': true}})
