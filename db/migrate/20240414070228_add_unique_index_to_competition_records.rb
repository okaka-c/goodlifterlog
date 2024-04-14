class AddUniqueIndexToCompetitionRecords < ActiveRecord::Migration[7.0]
  def change
    remove_index :competition_records, :competition_id
    add_index :competition_records, :competition_id, unique: true
  end
end
