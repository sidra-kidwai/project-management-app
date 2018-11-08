# frozen_string_literal: true

module ProjectsHelper
  def show_project_payments(project)
    if policy(Payment).index? && project.no_of_payments.positive?
      link_to project.no_of_payments, project_payments_path(project)
    else
      project.no_of_payments
    end
  end
end
