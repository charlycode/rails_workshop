class CreateReceipts < ActiveRecord::Migration
  def change
    create_table :receipts do |t|
      t.string :rfc_emisor
      t.string :rfc_receptor
      t.string :concept
      t.decimal :ammount
      t.decimal :tax
      t.decimal :total

      t.timestamps
    end
  end
end
