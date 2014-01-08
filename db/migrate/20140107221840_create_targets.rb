class CreateTargets < ActiveRecord::Migration
  def change
    create_table :targets do |t|
      t.string :name
      t.integer :roject_id
      t.boolean :complete
      t.date :target_date

      t.timestamps
    end
  end
end
