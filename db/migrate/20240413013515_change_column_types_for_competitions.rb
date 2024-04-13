class ChangeColumnTypesForCompetitions < ActiveRecord::Migration[7.0]
  def change
    def up
      change_column :competitions, :category, :string
      change_column :competitions, :age_group, :string
      change_column :competitions, :weight_class, :string
    end

    def down
      change_column :competitions, :category, :integer
      change_column :competitions, :age_group, :integer
      change_column :competitions, :weight_class, :integer
    end
  end
end
