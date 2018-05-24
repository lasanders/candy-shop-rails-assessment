class CandiesController < ApplicationController
before_action:set_candy, only: [:show, :edit, :update, :destroy]
def index
@candies= Candy.all
@purchases= Purchase.all
end

def show
  
@message= params[:message]
end


def new
@candy= Candy.new

end

def create
@candy= Candy.new(candy_params)
    if current_user.employee && @candy.save 
        redirect_to candy_path(@candy)
      else
        candy_error
render:new 
    end
end

def edit
@candy= Candy.find(params[:id])
end

def update
@candy= Candy.find(params[:id])
    if current_user.employee  && @candy.update(candy_params)
        redirect_to @candy
      else
          candy_error
render:edit 
    end
end

def candy_error
     if @candy.errors.any?
     @candy.errors.full_messages.each do |msg|
@error= msg
     end
     end
end

def destroy

@candy= Candy.last
        @candy.destroy
    redirect_to candies_path
end


private


def set_candy
@candy= Candy.find_by(params[:id])
end

def candy_params
params.require(:candy).permit(:name, :taste, :cost, :appetite, :count, user_attributes: [:name, :password, :taste, :cash, :appetite, :employee], user_ids: [], purchases_attributes: [:candy_id, :user_id], purchase_ids: [])
end

end


