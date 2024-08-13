Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins 'http://localhost:3000'
    origins '*'

    resource '*',
      headers: :any,
      methods: [:get, :post, :put, :patch, :delete, :options, :head]
  end
end

# https://www.youtube.com/watch?v=UOLpv2f8mz8&list=PLm8ctt9NhMNWD939gE728i13W999EFS0n&index=18
