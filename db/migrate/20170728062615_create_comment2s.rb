class CreateComment2s < ActiveRecord::Migration
  def change
    create_table :comment2s do |t|
      t.references :topic, index: true, foreign_key: true
      t.string :note

      t.timestamps null: false
    end
  end
end
