# frozen_string_literal: true

class BodyGoal < ApplicationRecord
  belongs_to :user

  validates :metric_name, presence: true
  validates :measurement_type, presence: true
  validates :target_value, presence: true, numericality: true
  validates :goal_date, presence: true

  # Calculate status based on latest snapshot entries
  def status
    days_remaining = (goal_date - Date.current).to_i
    
    # If no snapshots exist, check if goal date has passed
    if user.body_snapshots.empty?
      return days_remaining < 0 ? "failed" : "pending"
    end

    latest_entry = latest_snapshot_entry
    
    # If no entry for this specific metric, check date
    unless latest_entry
      return days_remaining < 0 ? "failed" : "pending"
    end

    current_value = latest_entry.value

    # Check if goal is achieved
    if goal_achieved?(current_value)
      return "done"
    end

    # Check if goal date has passed
    if days_remaining < 0
      return "failed"
    end

    # Check progress
    progress = calculate_progress(current_value)
    if progress >= 0.8
      "almost_there"
    elsif progress >= 0.5
      "on_track"
    elsif progress >= 0.25
      "in_progress"
    else
      "getting_started"
    end
  end

  def latest_snapshot_entry
    BodySnapshotEntry
      .joins(:body_snapshot)
      .where(body_snapshots: { user_id: user_id })
      .where(metric_name: metric_name, measurement_type: measurement_type)
      .order("body_snapshots.recorded_at DESC")
      .first
  end

  def current_value
    latest_snapshot_entry&.value
  end

  def progress_percentage
    return 0 unless current_value
    calculate_progress(current_value) * 100
  end

  private

  def goal_achieved?(current_value)
    return false unless current_value

    # For weight loss goals (lower is better)
    if measurement_type.downcase.include?("weight") || measurement_type.downcase.include?("loss")
      current_value <= target_value
    # For gain goals (higher is better)
    elsif measurement_type.downcase.include?("gain") || measurement_type.downcase.include?("increase")
      current_value >= target_value
    # For measurements (could be either, default to higher is better)
    else
      current_value >= target_value
    end
  end

  def calculate_progress(current_value)
    return 0 unless current_value

    # Get initial value from first snapshot or assume current value
    initial_entry = BodySnapshotEntry
                      .joins(:body_snapshot)
                      .where(body_snapshots: { user_id: user_id })
                      .where(metric_name: metric_name, measurement_type: measurement_type)
                      .order("body_snapshots.recorded_at ASC")
                      .first

    initial_value = initial_entry&.value || current_value

    # Calculate progress based on direction
    if measurement_type.downcase.include?("weight") || measurement_type.downcase.include?("loss")
      # For weight loss: progress is how much we've lost relative to target
      total_needed = initial_value - target_value
      return 1.0 if total_needed <= 0
      progress_made = initial_value - current_value
      [progress_made / total_needed, 1.0].min
    elsif measurement_type.downcase.include?("gain") || measurement_type.downcase.include?("increase")
      # For gains: progress is how much we've gained relative to target
      total_needed = target_value - initial_value
      return 1.0 if total_needed <= 0
      progress_made = current_value - initial_value
      [progress_made / total_needed, 1.0].min
    else
      # Default: assume higher is better
      total_needed = target_value - initial_value
      return 1.0 if total_needed <= 0
      progress_made = current_value - initial_value
      [progress_made / total_needed, 1.0].min
    end
  end
end

