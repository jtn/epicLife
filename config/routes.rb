EpicLife::Application.routes.draw do
  resources :people do
    # resources :activities
    resources :feats
  end

  resources :activities do
    # resources :feats
  end
end
