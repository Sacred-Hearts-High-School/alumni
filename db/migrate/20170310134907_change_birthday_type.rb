class ChangeBirthdayType < ActiveRecord::Migration[5.0]
  def change
  	change_column :members, :birthday, :string
  end
end
