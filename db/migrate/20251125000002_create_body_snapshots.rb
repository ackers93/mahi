# frozen_string_literal: true

class CreateBodySnapshots < ActiveRecord::Migration[8.1]
  def change
    create_table :body_snapshots do |t|
      t.references :user, null: false, foreign_key: true
      t.datetime :recorded_at, null: false

      t.timestamps null: false
    end

    add_index :body_snapshots, [:user_id, :recorded_at]
  end
end

