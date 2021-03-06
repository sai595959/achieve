module ApplicationHelper

  def profile_img(user,page)

    if page == 'blog'
      return image_tag(user.avatar, alt: user.name, class:'profile_img_round') if user.avatar?

      unless user.provider.blank?
        img_url = user.image_url
      else
        img_url = 'no_image.png'
      end
        image_tag(img_url, alt: user.name, class:'profile_img_round')

    elsif page == 'user_index'
      return image_tag(user.avatar, alt: user.name, class:'profile_img_index') if user.avatar?

      unless user.provider.blank?
        img_url = user.image_url
      else
        img_url = 'no_image.png'
      end
        image_tag(img_url, alt: user.name, class:'profile_img_index')

    else
      return image_tag(user.avatar, alt: user.name) if user.avatar?

      unless user.provider.blank?
        img_url = user.image_url
      else
        img_url = 'no_image.png'
      end
        image_tag(img_url, alt: user.name)
    end
end

end

module ActionView
  module Helpers
    module FormHelper
      def error_messages!(object_name, options = {})
        resource = self.instance_variable_get("@#{object_name}")
        return '' if !resource || resource.errors.empty?

        messages = resource.errors.full_messages.map { |msg| content_tag(:li, msg) }.join

        html = <<-HTML
          <div class="alert alert-danger">
            <ul>#{messages}</ul>
          </div>
        HTML

        html.html_safe
      end

      def error_css(object_name, method, options = {})
        resource = self.instance_variable_get("@#{object_name}")
        return '' if resource.errors.empty?

        resource.errors.include?(method) ? 'has-error' : ''
      end
    end

    class FormBuilder
      def error_messages!(options = {})
        @template.error_messages!(@object_name, options.merge(object: @object))
      end

      def error_css(method, options = {})
        @template.error_css(@object_name, method, options.merge(object: @object))
      end
    end
  end
end
