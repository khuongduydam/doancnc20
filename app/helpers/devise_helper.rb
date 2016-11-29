module DeviseHelper
  def devise_error_messages!
    if resource.errors.full_messages.any?
      flash.now[:error] = resource.errors.full_messages.join("<br>").html_safe
    end
    return 
  end

  def button_to_with_icon(text, path, classes)
    form_tag path, :method => :post do
      button_tag(classes) do
        raw text
      end
    end
  end
end