class AddPayToTimesheet < ActiveRecord::Migration[5.2]
  def change
    add_column :timesheets, :pay, :float
  end
end
