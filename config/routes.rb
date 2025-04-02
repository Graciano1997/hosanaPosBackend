Rails.application.routes.draw do
  mount Rswag::Ui::Engine => "/api-docs"
  mount Rswag::Api::Engine => "/api-docs"
  root "application#root", default: { format: :json }
  get "/api/products/product_fields", to: "api/products#product_fields"
  get "/api/products/expireds", to: "api/products#expireds"
  get "/api/products/anual_expireds/:year/", to: "api/products#anual_expireds"
  get "/api/spents/last_spents/:number/", to: "api/spents#last_spents"
  get "/api/spents/anual_spents/:year/", to: "api/spents#anual_spents"
  get "/api/spents/min_year_spends/", to: "api/spents#min_year_date_spents"
  get "/api/currencies/active/", to: "api/currencies#active"

  namespace :api do
    resources :products, default: { format: :json }
    resources :categories, default: { format: :json }
    resources :product_configurations, default: { format: :json }
    resources :spents, default: { format: :json }
    resources :users
    resources :profiles, default: { format: :json }
    resources :sales, default: { format: :json }
    resources :currencies, default: { format: :json }
  end
end
