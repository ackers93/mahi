# frozen_string_literal: true

class BodySnapshotEntry < ApplicationRecord
  belongs_to :body_snapshot

  validates :metric_name, presence: true
  validates :measurement_type, presence: true
  validates :value, presence: true, numericality: true
end


