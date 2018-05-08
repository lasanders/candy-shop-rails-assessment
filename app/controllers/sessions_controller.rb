class SessionsController < ApplicationController
  
   def new
       @user = User.new
       @users = User.all
   end
   
   
def create
     @user = User.find_by(name: params[:user][:name])
     if @user.authenticate(params[:password])
          session[:user_id] = @user.id
        # binding.pry
      redirect_to user_path(@user)
     else
      redirect_to '/signin'
       
end
end

 def other_create
 user = User.from_omniauth(request.env['omniauth.auth'])
    session[:user_id] = user.id
      redirect_to user_path(user)
  end

def destroy
    session[:user_id] = nil
    redirect_to root_url
end

 def other_destroy
    self.current_user = nil
    redirect_to root_url, notice: "Signed out successfully"
  end

private
# def auth
#     request.env['omniauth.auth']
#   end
end
