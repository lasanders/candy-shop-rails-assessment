class User < ActiveRecord::Base
    has_secure_password
    has_many :purchases
    has_many :candies, through: :purchases
    has_many :identities, dependent: :destroy
    validates_presence_of :taste, :cash, :appetite
    validates :cash, :appetite, numericality: { only_integer: true }
    
    
    
     def user_error
     if @user.errors.any?
        # pluralize(@user.errors.count, "error") 
     @user.errors.full_messages.each do |msg|
         @error = msg
     end
 end
 end
end
