class Purchase < ApplicationRecord
    belongs_to :user
    belongs_to :candy
    # scope :count, -> {where(candy.count)}   

    def cash_issue
    self.candy.cost >= self.user.cash
        #  binding.pry
    end
 
    def cash_problem
        "Sorry. You do not have enough money to buy #{self.candy.name}."
    end
      
    def hunger_issue
     self.user.appetite >= 75 
    
    end
    def hunger_problem
         "Sorry. You are not hungry enough to eat this #{self.candy.name}." 
    end
    def multiple_issues
         self.candy.appetite <= 75 && self.candy.cost >= self.user.cash
    end
    def multiple_problems
        "Sorry. You do not have enough money to buy #{self.candy.name}. Plus, you aren't hungry enough to eat #{self.candy.name}."
    end

    def get_cavities
        self.user.appetite <= 75 && self.candy.cost <= self.user.cash
    end
    
    def thank_you
        "Thanks for purchasing #{self.candy.name}!"
    end
    
    def hunger
       hunger_status = user.appetite
     if hunger_status >= 0 && hunger_status <= 25
         "WE NEED TO FEED YOU CANDY, STAT"
     elsif hunger_status >= 25 && hunger_status <= 50
        "You need more candy to function!"
     elsif hunger_status >= 50 && hunger_status <= 75
        "Maybe just a few more pieces!"
     elsif hunger_status >= 75 
        "You are way too full for candy right now!"
     end
    end
            
        
    def update_qualities
    new_appetite = self.user.appetite + self.candy.appetite
    new_taste = self.candy.taste
    new_cash =  self.user.cash - self.candy.cost
    new_count = self.candy.count - 1
    self.user.update(
      :appetite => new_appetite,
      :taste => new_taste,
      :cash => new_cash
    )
    self.candy.update(
     :count => new_count
        )
    end
    

    def purchase_candy
     
    if get_cavities
        update_qualities
        thank_you 
    elsif cash_issue && hunger_issue
         multiple_problems 
    elsif cash_issue 
      cash_problem 
    elsif hunger_issue  
      hunger_problem 
 
    end
    end
  def self.count
      candy.count
     end
end
