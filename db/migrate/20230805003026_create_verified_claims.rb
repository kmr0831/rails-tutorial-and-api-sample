class CreateVerifiedClaims < ActiveRecord::Migration[6.0]
  def change
    create_table :verified_claims do |t|
      t.references :ekyc_user, null: false, foreign_key: true
      t.string :name
      t.string :given_name
      t.string :family_name
      t.string :birthdate

      t.timestamps
    end
  end
end
