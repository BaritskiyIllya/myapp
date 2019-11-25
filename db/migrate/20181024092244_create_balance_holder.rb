class CreateBalanceHolder < ActiveRecord::Migration[5.2]
  def change
    create_table :balance_holders do |t|
      t.timestamps
    end

    reversible do |dir|
      dir.up do
        BalanceHolder.create_translation_table! name: :string
      end

      dir.down do
        BalanceHolder.drop_translation_table!
      end
    end
  end
end
