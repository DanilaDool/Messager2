class HomeController < ApplicationController
  def show
    @rooms = Room.all
  end
end
