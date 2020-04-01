Rails.application.routes.draw do
  get "/", to: "pages#index"
  get "/auth/google_oauth2/callback" => "sessions#create"
  get "/logout" => "sessions#destroy"
end
