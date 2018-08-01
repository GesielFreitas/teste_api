class CreateTransactions < ActiveRecord::Migration[5.1]
  def change
    create_table :transactions do |t|
      t.integer :type_transaction
      t.datetime :date_time
      t.float :value
      t.string :cpf
      t.string :credit_card

      t.timestamps
    end
  end
end
