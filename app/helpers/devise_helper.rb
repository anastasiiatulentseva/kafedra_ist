module DeviseHelper
  def devise_error_messages!
    return "" if resource.errors.empty?

    messages = resource.errors.full_messages.map { |msg| content_tag(:li, msg, class: "text-danger") }.join
    sentence = t('error_alert')

    html = <<-HTML
    <div id="error_explanation">
      <div class="alert alert-danger">
        #{sentence}
      </div>
      <ul>#{messages}</ul>
    </div>
    HTML

    html.html_safe
  end

  def devise_error_messages?
    resource.errors.present?
  end

end
