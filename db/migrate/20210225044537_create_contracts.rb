class CreateContracts < ActiveRecord::Migration[6.1]
  def change
    create_table :contracts do |t|
      t.text :terms
      t.references :company, null: false, foreign_key: true

      t.timestamps
    end
  end
end
