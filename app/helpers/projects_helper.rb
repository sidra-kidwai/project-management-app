module ProjectsHelper
  def show_project_payments(project, payments)
    if policy(Payment).index? && payments.present?
      link_to project.no_of_payments, project_payments_path(project)
    else
      project.no_of_payments
    end
  end
end
