class RemoveDefaultFromCompetitions < ActiveRecord::Migration[7.0]
  def change
    change_column_default :competitions, :competition_type, nil
    change_column_default :competitions, :gearcategory_type, nil
    change_column_default :competitions, :category, nil
    change_column_default :competitions, :age_group, nil
    change_column_default :competitions, :weight_class, nil
  end
end
