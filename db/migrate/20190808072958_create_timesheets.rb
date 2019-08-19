class CreateTimesheets < ActiveRecord::Migration[5.2]
  def change
    create_table :timesheets do |t|
      t.date :date
      t.time :start
      t.time :finish

      t.timestamps
    end
  end
end
