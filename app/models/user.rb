class User < ActiveRecord::Base
    has_secure_password
    has_many :purchases
    has_many :candies, through: :purchases
    

    def appetite
      
       hunger_status = self.appetite
     if hunger_status < 0
        "I'm too full for candy!"
     elsif hunger_status < 50
     "Maybe just a few more pieces!"
     elsif hunger_status < 75
    "I need more candy to function!"
     elsif hunger_status < 100
     "FEED ME CANDY, STAT"
     end
    end
end
