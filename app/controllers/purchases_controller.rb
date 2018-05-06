class PurchasesController < ApplicationController
    before_action :current_user
    helper_method :get_cavities

    
  def new
   @purchase = Purchase.new
   @user.purchases = @user.purchase.all
  end
  
  def create
     @purchase = Purchase.create(:user_id => params[:user_id], :candy_id => params[:candy_id])
     @message = @purchase.purchase_candy, @purchase.hunger
    redirect_to user_path(@purchase.user, :message => @message)
  end
  
private

def purchase_params
params.require(:purchase).permit(:user_id, :purchase_id)
end
end

