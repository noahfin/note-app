module ApplicationHelper
  
  def alert_box(kind="warning", title="Warning!", message="Warnings occurred")
    content_tag(:div, class:"alert alert-#{kind} alert-dismissible", role: "alert") do
      concat(content_tag(:button, type: 'button', class: 'close', data: {dismiss: 'alert'}) do
        concat content_tag(:span, raw('&times;'), "aria-hidden"=>"true")
        concat content_tag(:span, "Close", class:"sr-only")
      end)
      concat content_tag(:strong, title)
      concat " "
      concat message
    end
  end

  def gravatar_url()
        @email = User.find(current_user.id)

        @stripped_email = @email['email'].strip
        @downcased_email = @stripped_email.downcase
        hash = Digest::MD5.hexdigest(@downcased_email)
        'http://gravatar.com/avatar/' + hash.to_s
        
      end

  
end
