module RolloutUi
  class ApplicationController < ActionController::Base
    before_filter :check_admins

    def check_admins
      redirect_to '/access-denied' if (current_user.blank? || !current_user.can_access_admin_pages?)
    end

  end
end
