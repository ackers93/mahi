class CreateGoals < ActiveRecord::Migration[6.1]
  def change
    create_table :goals do |t|
      t.string :name
      t.text :description
      t.date :goal_date
      t.references :trainee, null: false, foreign_key: true

      t.timestamps
    end
  end
end
