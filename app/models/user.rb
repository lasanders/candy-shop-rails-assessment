class User < ActiveRecord::Base
    has_secure_password
    has_many :purchases
    has_many :candies, through: :purchases
    validates_presence_of :taste, :cash, :appetite
    accepts_nested_attributes_for :candies
    validates :cash, :appetite, numericality: { only_integer: true }
    validates :taste, inclusion: {in: %w(sweet sour), message: ": Please choose sweet or sour" }
    
      def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_initialize.tap  do |user|
      user.email = auth.info.email
      user.name = auth.info.name
      user.password = "temporary password"
        user.save!(validate: false)
    end
  end
  
    def candy_attributes=(candy)
      self.candy = Candy.find_or_create_by(name: candy.name)
      self.candy.update(candy)
  end
end

