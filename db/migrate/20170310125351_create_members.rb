class CreateMembers < ActiveRecord::Migration[5.0]
  def change
    create_table :members do |t|
      t.string :name
      t.string :pid
      t.date :birthday
      t.string :remark

      t.timestamps
    end
  end
end
