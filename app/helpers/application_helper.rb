module ApplicationHelper
  def bootstrap_class_for(flash_type)
    case flash_type
    when "success"
      "alert-success"
    when "error"
      "alert-danger"
    when "alert"
      "alert-warning"
    when "notice"
      "alert-info"
    else
      flash_type.to_s
    end
  end

  def active_class(link_path)
    current_page?(link_path) ? "active" : ""
  end

  def show_create_button(resource)
    link_to "Create New", new_polymorphic_path(resource), class: "btn btn-primary pull-right" if policy(resource).new?

  end

  def show_edit_button(resource)
    link_to "Edit", edit_polymorphic_path(resource), class: "btn btn-info" if policy(resource).edit?
  end

  def show_delete_button(resource)
    link_to "Delete", polymorphic_path(resource), method: :delete,
            data: {confirm: "Are you sure?"}, class: "btn btn-danger" if policy(resource).destroy?
  end

  def check_action_tag
    params[:action] == 'new' ? "Save" : "Save Changes"
  end

  def date_format(style, date)
    case style
    when 'date'
      date.strftime("%B %d, %Y")
    when 'time'
      date.strftime("%I:%M %p")
    else
      date.strftime("%m/%d/%Y")
    end
  end

  def currency_tag
    "$"
  end
end
