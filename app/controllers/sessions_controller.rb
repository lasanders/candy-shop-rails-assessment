class SessionsController < ApplicationController
  
   def new
       @user = User.new
       @users = User.all
   end
   
   
def create
        
    #  if user_info = request.env["omniauth.auth"]

    # @user           = User.new
    # @user.id        = user_info["uid"]
    # @user.name      = user_info["info"]["name"]
    # @user.email     = user_info["info"]["email"]
    # @user.taste      = user_info["info"]["sweet"]
    # @user.cash     = user_info["info"]["500"]
    # @user.appetite  = user_info["info"]["1"]
 
    # @user.save
    # session[:user] = @user

    # redirect_to user_path(@user)
    @user = User.find_by(name: params[:name])
     if @user.authenticate(params[:password])
          session[:user_id] = @user.id
        # binding.pry
      redirect_to user_path(@user)
else
      redirect_to '/signin'
#  end       
end
end

def destroy
    session[:user_id] = nil
    redirect_to root_url
end
end
