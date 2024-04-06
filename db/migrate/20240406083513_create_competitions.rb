class CreateCompetitions < ActiveRecord::Migration[7.0]
  def change
    create_table :competitions do |t|
      t.references :user, null: false, foreign_key: true
      t.string "name", null: false
      t.string "venue"
      t.date "date", null: false
      t.integer "type", default: 0, null: false
      t.integer "gearcategory_type", default: 0, null: false
      t.integer "category", default: 0, null: false
      t.integer "age_group", default: 0, null: false
      t.integer "weight_class", default: 0, null: false
      t.integer "participation_status", default: 0, null: false
      t.timestamps
    end
  end
end
