class CreateCompetitionRecords < ActiveRecord::Migration[7.0]
  def change
    create_table :competition_records do |t|
      t.references :competition, null: false, foreign_key: true
      t.float :weight, null: false
      t.float :squat_first_attempt, default: nil
      t.float :squat_second_attempt, default: nil
      t.float :squat_third_attempt, default: nil
      t.float :benchpress_first_attempt, default: nil
      t.float :benchpress_second_attempt, default: nil
      t.float :benchpress_third_attempt, default: nil
      t.float :deadlift_first_attempt, default: nil
      t.float :deadlift_second_attempt, default: nil
      t.float :deadlift_third_attempt, default: nil
      t.integer :squat_first_attempt_result, default: 0
      t.integer :squat_second_attempt_result, default: 0
      t.integer :squat_third_attempt_result, default: 0
      t.integer :benchpress_first_attempt_result, default: 0
      t.integer :benchpress_second_attempt_result, default: 0
      t.integer :benchpress_third_attempt_result, default: 0
      t.integer :deadlift_first_attempt_result, default: 0
      t.integer :deadlift_second_attempt_result, default: 0
      t.integer :deadlift_third_attempt_result, default: 0
      t.text :comment
      t.timestamps
    end
  end
end
