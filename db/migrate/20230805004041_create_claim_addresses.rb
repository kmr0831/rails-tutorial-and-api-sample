class CreateClaimAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :claim_addresses do |t|
      t.references :verified_claim, null: false, foreign_key: true
      t.string :street_address
      t.string :locality
      t.string :region
      t.string :posttal_code
      t.string :country

      t.timestamps
    end
  end
end
