# frozen_string_literal: true

module ApplicationHelper
  def bootstrap_class_for(flash_type)
    {
      'success' => 'alert-success',
      'error' => 'alert-danger',
      'alert' => 'alert-warning',
      'notice' => 'alert-info'
    }[flash_type] || flash_type
  end

  def active_class(link_path)
    current_page?(link_path) ? 'active' : ''
  end

  def show_create_button(resource)
    return unless policy(resource).new?

    link_to 'Create New', new_polymorphic_path(resource),
            class: 'btn btn-primary pull-right'
  end

  def show_edit_button(resource)
    link_to 'Edit', edit_polymorphic_path(resource), class: 'btn btn-info' if
    policy(resource).edit?
  end

  def show_delete_button(resource)
    return unless policy(resource).destroy?

    link_to 'Delete', polymorphic_path(resource), method: :delete,
                                                  data:
                                                  {
                                                    confirm: 'Are you sure?'
                                                  },
                                                  class: 'btn btn-danger'
  end

  def check_action_tag
    params[:action] == 'new' ? 'Save' : 'Save Changes'
  end

  def date_format(style, date)
    case style
    when 'date'
      date.strftime('%B %d, %Y')
    when 'time'
      date.strftime('%I:%M %p')
    else
      date.strftime('%m/%d/%Y')
    end
  end

  def currency_tag
    '$'
  end
end
