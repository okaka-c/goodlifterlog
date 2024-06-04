class AddUniqueIndexToCompetitionResults < ActiveRecord::Migration[7.0]
  def change
    remove_index :competition_results, :competition_record_id
    add_index :competition_results, :competition_record_id, unique: true
  end
end
