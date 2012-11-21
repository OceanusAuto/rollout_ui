RolloutUi::Engine.routes.draw do
  
  
  resources :features, :only => [:index, :update, :create, :new]
  post "features/delete" => "features#delete"
  root :to => "features#index"

  
end
