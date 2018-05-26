class PurchasesController < ApplicationController
    before_action :current_user

       def show
    #   candy = Candy.find_by(id: params[:candy_id])
       @user = User.find_by(id: params[:user_id])
      @purchase = @user.purchases.find_by(id: params[:id])
       end
    
    
  def new
       @message = params[:message]
   
   @purchase = Purchase.new(purchase_params)
  
  end
  
  def create
       @purchase = Purchase.new(:user_id => params[:user_id], :candy_id => params[:candy_id], :payment_type => params[:payment_type])
    #   binding.pry
    if @purchase.get_cavities
        @purchase.update(:payment_type => params[:payment_type])
     @purchase.save
    end
            #   binding.pry
            
     @message = @purchase.purchase_candy, @purchase.hunger
    redirect_to user_path(@purchase.user, :message => @message)

  end
  
     def purchase_error
     if @purchase.errors.any?
        # pluralize(@user.errors.count, "error") 
     @purchase.errors.full_messages.each do |msg|
         @error = msg
     end
     end
     end
  
private

def purchase_params
    # binding.pry
params.require(:purchase).permit(:user_id, :candy_id, :payment_type)

end
end

