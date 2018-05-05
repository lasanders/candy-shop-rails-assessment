class User < ActiveRecord::Base
    has_secure_password
    has_many :purchases
    has_many :candies, through: :purchases
    has_many :identities, dependent: :destroy
    validates_presence_of :taste, :cash, :appetite
    validates :taste, :cash, :appetite, numericality: { only_integer: true }
end
