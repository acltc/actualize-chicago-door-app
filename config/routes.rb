Rails.application.routes.draw do
  get "/" => "pages#index"
  get "/admin" => "pages#admin"

  get "/users" => "users#index"
  get "/users/new" => "users#new"
  post "/users" => "users#create"
  get "/users/:id/edit" => "users#edit"
  patch "/users/:id" => "users#update"
  delete "/users/:id" => "users#destroy"

  get "/auth/google_oauth2/callback" => "sessions#create"
  get "/logout" => "sessions#destroy"

  post "/entrance_requests" => "entrance_requests#create"
end
