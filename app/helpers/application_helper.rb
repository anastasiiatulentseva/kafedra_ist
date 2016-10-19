module ApplicationHelper

  # Returns the full title on a per-page basis.
  def full_title(page_title = '')
    base_title = t('kafedra_ist')
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

  def format_image_extensions_for_file_field(extensions)
    image_extensions = extensions.map { |extension| 'image/' + extension }
    image_extensions.join(',')
  end

end
