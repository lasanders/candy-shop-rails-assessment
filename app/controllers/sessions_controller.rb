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
    auth = request.env['omniauth.auth']
    origin = request.env['omniauth.origin']
    destination = origin.blank? ? root_path : origin
    @identity = Identity.find_with_omniauth(auth)
    @identity = Identity.create_with_omniauth(auth) if @identity.nil?

    if logged_in?
      if @identity.user == current_user
        # Identity is already associated with this user
        redirect_to user_path(@user), notice: "Already logged in and linked"
      else
      @identity.user = current_user
        @identity.save()
        redirect_to user_path(@user), notice: "Account was successfully linked"
      end
    else
      if @identity.user.present?
        # Identity has a user associated with it
        self.current_user = @identity.user
        redirect_to user_path(@user)
      else
        # No user associated with the identity so create a new one
        # user = User.create_with_omniauth(auth['info'])
        # @identity.user = user
        # @identity.save()
        # self.current_user = @identity.user
        redirect_to '/users/new', notice: "I'm sorry. Something went wrong. Please create an account"
      end
    end
  end

  def other_destroy
    self.current_user = nil
    redirect_to root_url, notice: "Signed out successfully"
  end

  def omniauth_failure
    origin = request.env['omniauth.origin']
    destination = origin.blank? ? root_path : origin
    redirect_to destination, alert: "Connection failed"
  end

def destroy
    session[:user_id] = nil
    redirect_to root_url
end
end
