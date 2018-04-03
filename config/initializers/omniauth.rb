Rails.application.config.middleware.use OmniAuth::Builder do
  #provider :google_oauth2, ENV['GOOGLE_CLIENT_ID'], ENV['GOOGLE_CLIENT_SECRET']
  provider :google_oauth2, ENV['GOOGLE_OAUTH_CLIENT_ID'], ENV['GOOGLE_OAUTH_SECRET'], provider_ignores_state: true
  #provider provider_ignores_state: true
end
