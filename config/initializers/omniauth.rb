Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['FACEBOOK_KEY'], ENV['FACEBOOK_SECRET']
end

#telling the app to use a piece of middleware created by OmniAuth for the facebook authentication strategy