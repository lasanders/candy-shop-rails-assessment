class User < ActiveRecord::Base
    has_secure_password
    devise :omniauthable, omniauth_providers: [:google_oauth2]
    has_many :purchases
    has_many :candies, through: :purchases
    validates_presence_of :taste, :cash, :appetite
    validates :taste, :cash, :appetite, numericality: { only_integer: true }
   
end
