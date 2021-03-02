class CreateUserSchedules < ActiveRecord::Migration[6.1]
  def change
    create_table :user_schedules do |t|
      t.integer :week
      t.integer :day
      t.integer :block, index: true
      t.datetime :time
      t.boolean :available, default: false
      t.references :user, null: false, foreign_key: true
      t.references :company, null: false, foreign_key: true

      t.timestamps
    end
  end
end
