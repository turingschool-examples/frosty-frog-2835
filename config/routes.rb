Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  resources :doctors, only: [:show]
  delete "/doctors/:doctor_id/patients/:id", to: "doctors_patients#destroy"
  #resources :doctor_patients, only: [:destroy]
end
