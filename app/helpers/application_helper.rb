module ApplicationHelper

  # Returns the full title on a per-page basis.
  def full_title(page_title = '')
    base_title = "Kafedra IST"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end

  # Makes readable messages about allowed file extensions
  def format_extensions_for_file_field(extensions)
    extensions.join('/')
  end


end
