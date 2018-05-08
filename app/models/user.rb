class User < ActiveRecord::Base
    has_secure_password
    has_many :purchases
    has_many :candies, through: :purchases
    # validates_presence_of :taste, :cash, :appetite
    # validates :cash, :appetite, numericality: { only_integer: true }
    
      def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_initialize.tap  do |user|
      user.email = auth.info.email
      user.name = auth.info.name
      user.password = "temporary password"
        user.save!
    end
  end
end

