class FruitsController < ApplicationController

  def index
    @fruits = Fruit.all
  end

  def show
  end
end
