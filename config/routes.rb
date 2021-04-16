Rails.application.routes.draw do
  resources :goals
  devise_for :trainees
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: "goals#index"
end
