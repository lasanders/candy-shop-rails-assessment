class PurchasesController < ApplicationController
    before_action :current_user
    
  def new
      @user = User.find(params[:id])
   @purchase = Purchase.new
  
  end
  
  def create
       @purchase = Purchase.new(:user_id => params[:user_id], :candy_id => params[:candy_id])
    if @purchase.get_cavities
     @purchase.save
    end
            #   binding.pry
            
     @message = @purchase.purchase_candy, @purchase.hunger
    redirect_to user_path(@purchase.user, :message => @message)

  end
  
private

def purchase_params
params.require(:purchase).permit(:user_id, :candy_id)
end
end

