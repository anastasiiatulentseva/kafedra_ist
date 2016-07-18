
do ->
  onLoad = ->
    window['rangy'].initilized = false
    $('.text-wysiwyg').wysihtml5({'toolbar': {'html': true}})

  $(document).on('turbolinks:load', onLoad)