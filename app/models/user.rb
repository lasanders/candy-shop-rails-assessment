class User < ActiveRecord::Base
    has_secure_password
    has_many :purchases
    has_many :candies, through: :purchases
    validates_presence_of :taste
    validates_presence_of :cash
    validates_presence_of :appetite


end
