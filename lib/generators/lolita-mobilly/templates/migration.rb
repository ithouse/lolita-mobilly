class CreateLolitaMobillyTransaction < ActiveRecord::Migration
  class << self
    def up
      create_table :mobilly_transactions do |t|
        t.string :transaction_id, :length => 28
        t.integer :transaction_code
        t.string :status, :default => "processing"
        t.references :paymentable, :polymorphic => true
        t.string :ip, :length => 10

        t.timestamps
      end

      add_index :mobilly_transactions, [:paymentable_type,:paymentable_id], :name => "mobilly_trx_paymentable_type_paymentable_id"
    end

    def down
      drop_table :mobilly_transactions
    end
  end
end