class PaymentPolicy < ApplicationPolicy

  def index?
    @user.manager?
  end

end
