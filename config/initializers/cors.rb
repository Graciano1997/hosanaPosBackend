# config/initializers/cors.rb

Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    # origins "https://hosanna-pos-front.vercel.app"
    origins "*"
    resource "*",
      headers: :any,
      methods: [ :get, :post, :put, :patch, :delete, :options, :head ]
    # credentials: false  # Enable credentials if needed
  end
end
