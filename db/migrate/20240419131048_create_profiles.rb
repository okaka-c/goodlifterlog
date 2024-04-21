class CreateProfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :profiles do |t|
      t.integer :gender, null: false
      t.date :birthday, null: false
      t.references :user, null: false, unique: true, foreign_key: true

      t.timestamps
    end
  end
end
