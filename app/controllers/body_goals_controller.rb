# frozen_string_literal: true

class BodyGoalsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_body_goal, only: [:show, :edit, :update, :destroy]

  def index
    @body_goals = current_user.body_goals.order(created_at: :desc)
  end

  def show
  end

  def new
    @body_goal = current_user.body_goals.build
  end

  def create
    @body_goal = current_user.body_goals.build(body_goal_params)

    if @body_goal.save
      redirect_to body_goals_path, notice: "Goal created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @body_goal.update(body_goal_params)
      redirect_to body_goals_path, notice: "Goal updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @body_goal.destroy
    redirect_to body_goals_path, notice: "Goal deleted successfully."
  end

  private

  def set_body_goal
    @body_goal = current_user.body_goals.find(params[:id])
  end

  def body_goal_params
    params.require(:body_goal).permit(:metric_name, :measurement_type, :target_value, :goal_date, :note)
  end
end

