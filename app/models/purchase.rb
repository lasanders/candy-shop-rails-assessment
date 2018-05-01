class Purchase < ApplicationRecord
    belongs_to :user
    belongs_to :candy
        

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
        "Sorry. You do not have enough money to buy #{self.candy.name}. Sorry. You are not hungry enough to eat this #{self.candy.name}."
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
         "FEED ME CANDY, STAT"
     elsif hunger_status >= 25 && hunger_status <= 50
      "I need more candy to function!"
     elsif hunger_status >= 50 && hunger_status <= 75
     "Maybe just a few more pieces!"
     elsif hunger_status >= 75 
     "I'm too full for candy!"
     end
    end
            
        
    def update_qualities
    new_appetite = self.user.appetite + self.candy.appetite
    new_taste = self.candy.taste
    new_cash =  self.user.cash - self.candy.cost
    self.user.update(
      :appetite => new_appetite,
      :taste => new_taste,
      :cash => new_cash
    )
    end
    

    def purchase_candy
    if get_cavities
        update_qualities
        thank_you && hunger
     elsif cash_issue && hunger_issue
         multiple_problems && hunger
     elsif cash_issue 
      cash_problem && hunger
      hunger
    elsif hunger_issue  
      hunger_problem 
      hunger
    end
    end
    
    def candy_dollars
        # @candy = Candy.find_by([:id])
        # @purchase = Purchase.create(:user_id => params[:user_id], :candy_id => params[:candy_id])
        total_cash = []
        total_cash << self.user.cash
    end
end
