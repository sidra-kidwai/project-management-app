# frozen_string_literal: true

ActiveAdmin.register_page 'Dashboard' do
  menu priority: 1, label: proc { I18n.t('active_admin.dashboard') }

  content title: proc { I18n.t('active_admin.dashboard') } do
    div class: 'blank_slate' do
      div class: 'column' do
        h3 'Monthly Hours Logged'
        @monthly_hours = TimeLog.check_monthly_hours
        render partial: 'shared/chart', locals: { object: @monthly_hours }
      end
      div class: 'column' do
        h3 'Monthly Payments'
        @monthly_payments = Payment.check_monthly_earning
        render partial: 'shared/chart', locals: { object: @monthly_payments }
      end
    end

    # Here is an example of a simple dashboard with columns and panels.
    #
    # columns do
    #   column do
    #     panel "Recent Posts" do
    #       ul do
    #         Post.recent(5).map do |post|
    #           li link_to(post.title, admin_post_path(post))
    #         end
    #       end
    #     end
    #   end

    #   column do
    #     panel "Info" do
    #       para "Welcome to ActiveAdmin."
    #     end
    #   end
    # end
  end
end
