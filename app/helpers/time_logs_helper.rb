# frozen_string_literal: true

module TimeLogsHelper
  def show_new_time_log(project)
    link_to (fa_icon 'clock-o', text: 'New TimeLog'), new_project_time_log_path(project), remote: true, class: 'btn btn-primary btn-xs' if policy(TimeLog).new? && project.assigned?(current_user)
  end
end
