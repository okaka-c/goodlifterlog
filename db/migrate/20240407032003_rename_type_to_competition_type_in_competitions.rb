class RenameTypeToCompetitionTypeInCompetitions < ActiveRecord::Migration[7.0]
  def change
    rename_column :competitions, :type, :competition_type
  end
end
