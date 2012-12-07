module RolloutUi
  class ApplicationController < ActionController::Base
    before_filter :check_admins

    def check_admins
      admins =  REDIS_CONFIG[Rails.env][:admins]
      redirect_to '/access-denied' if (current_user.nil? or !admins.include?(current_user.login))
      #head :unauthorized
    end

  end
end
