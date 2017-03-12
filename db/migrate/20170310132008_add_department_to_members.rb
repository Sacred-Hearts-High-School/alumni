class AddDepartmentToMembers < ActiveRecord::Migration[5.0]
  def change
  	add_column :members, :department, :integer
  end
end
