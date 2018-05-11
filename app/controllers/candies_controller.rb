class CandiesController < ApplicationController
     before_action :set_candy, only: [:show, :edit, :update, :destroy]
def index
    @candies = Candy.all
    @purchases = Purchase.all
end

def show
  @candy = Candy.find(params[:id])
  
  @message = params[:message]
end


def new
    @candy = Candy.new
end

def create
    @candy = Candy.new(candy_params)
    if current_user.employee
        @candy.save
    redirect_to @candy
else
    render :new
    end
end

def edit
    @candy = Candy.find(params[:id])
end

def update
    @candy = Candy.find(params[:id])
    if current_user.employee 
    @candy.update(candy_params)
    @candy.save
        redirect_to @candy
    else
        render :edit
    end
end

def candy_error
     if @candy.errors.any?
        # pluralize(@user.errors.count, "error") 
     @candy.errors.full_messages.each do |msg|
         @error = msg
     end
     end
    end

def destroy
    @candy = Candy.find(params[:id])
        @candy.destroy
    redirect_to candies_path
end


private


def set_candy
    @candy = Candy.find_by(params[:id])
end

def candy_params
params.require(:candy).permit(:name, :taste, :cost, :appetite, :count)
end

end

