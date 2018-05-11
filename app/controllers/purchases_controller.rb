class PurchasesController < ApplicationController
    before_action :current_user
    # validates :@user.appetite >=75
    
  def new
      @user = User.find(params[:id])
   @purchase = Purchase.new
  
  end
  
  def create
      
     @purchase = Purchase.create(:user_id => params[:user_id], :candy_id => params[:candy_id])
            #   binding.pry
     @message = @purchase.purchase_candy, @purchase.hunger
    redirect_to user_path(@purchase.user, :message => @message)

end
  
private

def purchase_params
params.require(:purchase).permit(:user_id, :candy_id)
end
end

