# frozen_string_literal: true

class BodySnapshot < ApplicationRecord
  belongs_to :user
  has_many :body_snapshot_entries, dependent: :destroy

  validates :recorded_at, presence: true

  accepts_nested_attributes_for :body_snapshot_entries, allow_destroy: true, reject_if: :all_blank
end

