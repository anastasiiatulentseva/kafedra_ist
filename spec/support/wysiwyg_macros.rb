module WysiwygMacros

  def fill_wysiwyg(element_id, text)
    page.execute_script <<-JS
    $("#{element_id}").data("wysihtml5").editor.setValue('#{text}');
    JS
  end
end
