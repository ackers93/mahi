# frozen_string_literal: true

class BodySnapshotsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_body_snapshot, only: [:show, :edit, :update, :destroy]

  def index
    @body_snapshots = current_user.body_snapshots.order(recorded_at: :desc)
  end

  def show
  end

  def new
    @body_snapshot = current_user.body_snapshots.build(recorded_at: Time.current)
    @body_goals = current_user.body_goals.order(:metric_name)
    # Pre-populate entries based on existing goals
    @body_goals.each do |goal|
      @body_snapshot.body_snapshot_entries.build(
        metric_name: goal.metric_name,
        measurement_type: goal.measurement_type
      )
    end
  end

  def create
    @body_snapshot = current_user.body_snapshots.build(body_snapshot_params)

    if @body_snapshot.save
      redirect_to body_goals_path, notice: "Check-in recorded successfully."
    else
      @body_goals = current_user.body_goals.order(:metric_name)
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @body_goals = current_user.body_goals.order(:metric_name)
  end

  def update
    if @body_snapshot.update(body_snapshot_params)
      redirect_to body_snapshots_path, notice: "Check-in updated successfully."
    else
      @body_goals = current_user.body_goals.order(:metric_name)
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @body_snapshot.destroy
    redirect_to body_snapshots_path, notice: "Check-in deleted successfully."
  end

  private

  def set_body_snapshot
    @body_snapshot = current_user.body_snapshots.find(params[:id])
  end

  def body_snapshot_params
    params.require(:body_snapshot).permit(:recorded_at, body_snapshot_entries_attributes: [:id, :metric_name, :measurement_type, :value, :_destroy])
  end
end


