class Goal < ApplicationRecord
  belongs_to :trainee
  has_many :goal_steps
end
