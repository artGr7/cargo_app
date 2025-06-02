class HomeController < ApplicationController
  def index
    if user_signed_in?
      @orders = current_user.orders.order(created_at: :desc).limit(10)
    end
  end
end