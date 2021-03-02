class CreateCompanySchedules < ActiveRecord::Migration[6.1]
  def change
    create_table :company_schedules do |t|
      t.integer :week
      t.integer :day
      t.integer :block, index: true
      t.datetime :time
      t.references :user, null: true, index: true
      t.references :company, null: false, foreign_key: true

      t.timestamps
    end
  end
end
