class User < ActiveRecord::Base
    has_secure_password
    devise :omniauthable, omniauth_providers: [:google_oauth2]
    has_many :purchases
    has_many :candies, through: :purchases
    validates_presence_of :taste, :cash, :appetite
    validates :taste, :cash, :appetite, numericality: { only_integer: true }
   
   
   def self.from_omniauth(auth)
  where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
    user.email = auth.info.email
    user.password = Devise.friendly_token[0,20]
    user.name = auth.info.name   # assuming the user model has a name
  end
end
end
