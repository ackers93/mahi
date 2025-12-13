# frozen_string_literal: true

class CreateBodyGoals < ActiveRecord::Migration[8.1]
  def change
    create_table :body_goals do |t|
      t.references :user, null: false, foreign_key: true
      t.string :metric_name, null: false
      t.string :measurement_type, null: false
      t.decimal :target_value, null: false, precision: 10, scale: 2
      t.date :goal_date, null: false
      t.text :note

      t.timestamps null: false
    end

    add_index :body_goals, [:user_id, :metric_name]
  end
end


