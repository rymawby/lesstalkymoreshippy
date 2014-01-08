class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.integer :creator_id
      t.integer :validator_id
      t.string :title
      t.string :description

      t.timestamps
    end
  end
end
