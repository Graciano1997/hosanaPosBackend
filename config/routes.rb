Rails.application.routes.draw do
  mount Rswag::Ui::Engine => "/api-docs"
  mount Rswag::Api::Engine => "/api-docs"
  root "application#root", default: { format: :json }
  get "/api/products/product_fields", to: "api/products#product_fields"

  namespace :api do
    resources :products, default: { format: :json }
    resources :categories, default: { format: :json }
    resources :product_configurations, default: { format: :json }
    resources :spents, default: { format: :json }
    resources :users
    resources :profiles, default: { format: :json }
    resources :sales, default: { format: :json }
  end
end
