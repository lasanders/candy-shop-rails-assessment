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
 @user = User.find_or_create_by(uid: auth['uid']) do |u|
       
      u.name = auth['info']['name']
      u.email = auth['info']['email']
      u.uid = auth['uid']
      u.taste ="sweet"
      u.appetite = 1
      u.cash = 10
#   binding.pry
end
    session[:user_id] = @user.id
      redirect_to user_path(@user)

  end

def destroy
    session[:user_id] = nil
    redirect_to root_url
end

private
def auth
    request.env['omniauth.auth']
  end
end
