class RenameRojectIdToProjectId < ActiveRecord::Migration
  def change
  	rename_column :targets, :roject_id, :project_id
  end
end
