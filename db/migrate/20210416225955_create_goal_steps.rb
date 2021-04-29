class CreateGoalSteps < ActiveRecord::Migration[6.1]
  def change
    create_table :goal_steps do |t|
      t.string :name
      t.date :goal_steps_date
      t.references :goal, null: false, foreign_key: true

      t.timestamps
    end
  end
end
