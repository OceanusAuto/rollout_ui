module RolloutUi
  class ApplicationController < ActionController::Base
    before_filter :check_admins

    def check_admins
      admins =  REDIS_CONFIG[Rails.env][:admins]
      head :unauthorized if (current_user.nil? or !admins.include?(current_user.login))
    end

  end
end
