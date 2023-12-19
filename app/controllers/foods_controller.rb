class FoodsController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = current_user
    @foods = @user.foods.all
  end

  def show; end

  def new
    @food = Food.build
  end

  def create
    @user = current_user
    @food = @user.foods.build(food_params)
    @food.user_id = @user.id
    if @food.save
      redirect_to foods_path(@user), notice: 'Food was successfully created.'
    else
      render :new, alert: 'Failed to create food.'
    end
  end

  def destroy
    @food = Food.find(params[:id])
    if @food.destroy
      redirect_to foods_path, notice: 'Food was successfully deleted.'
    else
      flash[:alert] = 'Failed to delete food.'
    end
  end

  private

  def food_params
    params.require(:food).permit(:name, :measurement_unit, :price, :quantity, :user_id)
  end
end
