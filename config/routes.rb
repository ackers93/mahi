Rails.application.routes.draw do
  resources :goals do
    resources :goal_steps
  end
  devise_for :trainees
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: "main#index"
end
