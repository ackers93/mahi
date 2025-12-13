class HomeController < ApplicationController
  def index
    if user_signed_in?
      @body_goals = current_user.body_goals.order(created_at: :desc).limit(6)
    end
  end
end


