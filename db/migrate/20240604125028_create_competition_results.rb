class CreateCompetitionResults < ActiveRecord::Migration[7.0]
  def change
    create_table :competition_results do |t|
      t.references :competition_record, null: false, foreign_key: true, unique: true
      t.float :best_squat_weight, default: nil
      t.float :best_benchpress_weight, default: nil
      t.float :best_deadlift_weight, default: nil
      t.float :total_lifted_weight, default: nil
      t.float :ipf_points, default: nil
      t.timestamps
    end
  end
end
