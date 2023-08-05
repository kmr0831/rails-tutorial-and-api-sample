class CreateEkycUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :ekyc_users do |t|
      t.string :uuid, limit: 64, null: false
      t.string :display_name, null: false

      t.timestamps
    end
  end
end
