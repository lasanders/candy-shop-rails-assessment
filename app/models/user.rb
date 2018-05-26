class User < ActiveRecord::Base
    has_secure_password
    has_many :purchases
    has_many :candies, through: :purchases
    validates_presence_of :taste, :cash, :appetite
    validates :cash, :appetite, numericality: { only_integer: true }
    validates :taste, inclusion: {in: %w(sweet sour), message: ": Please choose sweet or sour" }
    accepts_nested_attributes_for :purchases
     
    scope :full, -> { where('appetite >= 75')}
    scope :satisfied, -> { where('appetite >=50' && 'appetite < 75')}
    scope :hungry, -> { where('appetite >=0' && 'appetite < 50')}
    
      def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_initialize.tap  do |user|
      user.email = auth.info.email
      user.name = auth.info.name
      user.password = "temporary password"
        user.save!(validate: false)
    end
  end

  
end

