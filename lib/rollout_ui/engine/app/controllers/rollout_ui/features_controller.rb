module RolloutUi
  class FeaturesController < RolloutUi::ApplicationController
    before_filter :wrapper, :only => [:index, :new, :notifications]

    def index
      @features = @wrapper.features.map{ |feature| RolloutUi::Feature.new(feature) unless feature.include?(D360Core::NotificationsAccess::NAMESPACE)}.compact
    end

    def notifications
      @rollout_heading = "Dealer360 Notification Access TTR"
      @features = @wrapper.features.map{ |feature| RolloutUi::Feature.new(feature) if feature.include?(D360Core::NotificationsAccess::NAMESPACE)}.compact
      render :index
    end
    
    def new
      @features = @wrapper.features.map{ |feature| RolloutUi::Feature.new(feature) }
    end

    def create
      feature = RolloutUi::Feature.new(params[:feature_id])
      feature.create         
      redirect_to features_path
    end
    
    def delete
      feature = RolloutUi::Feature.new(params[:feature_id])
      feature.remove       
      redirect_to features_path
    end

    def update
      @feature = RolloutUi::Feature.new(params[:id])

      @feature.percentage = params["percentage"] if params["percentage"]
      @feature.groups     = params["groups"]     if params["groups"]
      @feature.user_ids   = params["users"]      if params["users"]

      redirect_to features_path
    end
    
    def redirect_to(options = {}, response_status = {})
      if request.xhr?
        render(:update) {|page| page.redirect_to(options)}
      else
        super(options, response_status)
      end
    end


  private

    def wrapper
      @wrapper = RolloutUi::Wrapper.new
    end
  end
end
