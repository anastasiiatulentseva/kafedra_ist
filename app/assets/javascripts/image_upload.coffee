do ->
  $(document).on 'turbolinks:load', ->
    $('.picture-size-check').bind 'change', ->
      size_in_megabytes = @files[0].size / 1024 / 1024
      if size_in_megabytes > 5
        alert 'Maximum file size is 5MB. Please choose a smaller file.'
