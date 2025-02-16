Rails.application.routes.draw do
  mount Rswag::Ui::Engine => "/api-docs"
  mount Rswag::Api::Engine => "/api-docs"
  root "application#root", default: { format: :json }
  namespace :api do
    resources :products, default: { format: :json }
    resources :categories, default: { format: :json }
  end
end
