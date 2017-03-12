class AddNoToMembers < ActiveRecord::Migration[5.0]
  def change
  	add_column :members, :no, :string
  end
end
