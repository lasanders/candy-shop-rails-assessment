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
     self.candy.appetite >= self.user.appetite
    
    end
    def hunger_problem
         "Sorry. You are not hungry enough to eat this #{self.candy.name}." 
    end
    def multiple_issues
         self.candy.appetite >= self.user.appetite && self.candy.cost >= self.user.cash
    end
    def multiple_problems
        "Sorry. You do not have enough money to buy #{self.candy.name}. Sorry. You are not hungry enough to eat this #{self.candy.name}."
    end

    def get_cavities
        self.candy.appetite <= self.user.appetite && self.candy.cost <= self.user.cash
    end
    
    def thank_you
        "Thanks for purchasing #{self.candy.name}!"
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
        thank_you
    elsif cash_issue && !hunger_issue
       cash_problem
    elsif hunger_issue && !cash_issue  
       hunger_problem
    elsif cash_issue && hunger_issue
        multiple_problems
    end
 
#   binding.pry
    end
end

