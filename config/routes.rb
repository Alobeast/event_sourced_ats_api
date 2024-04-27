Rails.application.routes.draw do
  resources :jobs, only: [:index]
  resources :applications, only: [:index]
end
