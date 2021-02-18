class CreateLinks < ActiveRecord::Migration[6.0]
  def change
    create_table :links do |t|
      t.references :post, null: false, foreign_key: true
      t.string :url

      t.timestamps
    end
  end
end
