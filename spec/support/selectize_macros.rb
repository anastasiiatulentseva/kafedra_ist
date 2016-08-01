module SelectizeMacros

  def choose_from_selectize(parent, value)
    within(parent) do
      find('.selectize-input').click
      dropdown_option = find(".selectize-dropdown-content .option[data-value='#{value}']")
      dropdown_option.click if dropdown_option.visible?
    end
  end

end
