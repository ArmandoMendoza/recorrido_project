class CreateContractSchedules < ActiveRecord::Migration[6.1]
  def change
    create_table :contract_schedules do |t|
      t.string :day
      t.string :start_hour
      t.integer :hours
      t.references :contract, null: false, foreign_key: true

      t.timestamps
    end
  end
end
