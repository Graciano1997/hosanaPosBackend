Rails.application.routes.draw do
  mount Rswag::Ui::Engine => "/api-docs"
  mount Rswag::Api::Engine => "/api-docs"
  root "application#root", default: { format: :json }
  get "/api/products/product_fields", to: "api/products#product_fields", default: { format: :json }
  get "/api/products/expireds", to: "api/products#expireds", default: { format: :json }
  get "/api/products/expired_product_job", to: "api/products#expired_product_job", default: { format: :json }
  get "/api/spents/last_spents/:number/", to: "api/spents#last_spents", default: { format: :json }
  get "/api/sales/anual_sales/:year/", to: "api/sales#anual_sales", default: { format: :json }
  get "/api/sales/reprint/:id/", to: "api/sales#reprinting_invoice", default: { format: :json }
  get "/api/spents/anual_spents/:year/", to: "api/spents#anual_spents", default: { format: :json }
  get "/api/products/anual_expireds/:year/", to: "api/products#anual_expireds", default: { format: :json }
  get "/api/spents/min_year_spends/", to: "api/spents#min_year_date_spents", default: { format: :json }
  get "/api/currencies/active/", to: "api/currencies#active", default: { format: :json }
  post "/api/authentication/login", to: "api/authentication#login", default: { format: :json }
  get "/api/profiles/init", to: "api/profiles#init", default: { format: :json }
  post "/api/export/excel", to: "api/export#to_excel", defaults: { format: :xlsx }

  namespace :api do
    resources :products, default: { format: :json }
    resources :categories, default: { format: :json }
    resources :product_configurations, default: { format: :json }
    resources :spents, default: { format: :json }
    resources :users, default: { format: :json }
    resources :profiles, default: { format: :json }
    resources :sales, default: { format: :json }
    resources :currencies, default: { format: :json }
    resources :companies, default: { format: :json }
    resources :clients, default: { format: :json }
  end
end
