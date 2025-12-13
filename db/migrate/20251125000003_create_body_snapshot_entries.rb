# frozen_string_literal: true

class CreateBodySnapshotEntries < ActiveRecord::Migration[8.1]
  def change
    create_table :body_snapshot_entries do |t|
      t.references :body_snapshot, null: false, foreign_key: true
      t.string :metric_name, null: false
      t.string :measurement_type, null: false
      t.decimal :value, null: false, precision: 10, scale: 2

      t.timestamps null: false
    end

    add_index :body_snapshot_entries, [ :body_snapshot_id, :metric_name ]
  end
end

