class AddColumnTimeColumnsToContract < ActiveRecord::Migration[6.1]
  def change
    add_column :contracts, :start_date, :date
    add_column :contracts, :end_date, :date
  end
end
