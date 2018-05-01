class CandiesController < ApplicationController
     before_action :set_candy, only: [:show, :edit, :update, :destroy]
def index
    @candies = Candy.all
end

def show
  @candy = Candy.find(params[:id])
end

def new
    @candy = Candy.new
end

def create
    @candy = Candy.new(candy_params)
    if current_user.employee
        @candy.save
    redirect_to candy_path(@candy)
else
    redirect_to root_url
    end
end

def edit
end

def update
    if @candy.update(candy_params)
        redirect_to @candy
    else
        render :edit
    end
end

def destroy
        @candy.destroy
    redirect_to root_url
end

private


def set_candy
    @candy = Candy.find_by(params[:id])
end

def candy_params
params.require(:candy).permit(:name, :taste, :cost, :appetite)
end

end

