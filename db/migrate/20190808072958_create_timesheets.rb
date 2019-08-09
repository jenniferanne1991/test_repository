class CreateTimesheets < ActiveRecord::Migration[5.2]
  def change
    create_table :timesheets do |t|
      t.datetime :start
      t.datetime :finish

      t.timestamps
    end
  end
end
