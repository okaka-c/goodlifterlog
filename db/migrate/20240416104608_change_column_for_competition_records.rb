class ChangeColumnForCompetitionRecords < ActiveRecord::Migration[7.0]
  def change
    change_column_null :competition_records, :squat_first_attempt_result, false
    change_column_null :competition_records, :squat_second_attempt_result, false
    change_column_null :competition_records, :squat_third_attempt_result, false
    change_column_null :competition_records, :benchpress_first_attempt_result, false
    change_column_null :competition_records, :benchpress_second_attempt_result, false
    change_column_null :competition_records, :benchpress_third_attempt_result, false
    change_column_null :competition_records, :deadlift_first_attempt_result, false
    change_column_null :competition_records, :deadlift_second_attempt_result, false
    change_column_null :competition_records, :deadlift_third_attempt_result, false
  end
end
