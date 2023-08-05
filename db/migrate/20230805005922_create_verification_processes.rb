class CreateVerificationProcesses < ActiveRecord::Migration[6.0]
  def change
    create_table :verification_processes do |t|
      t.references :verified_claim, null: false, foreign_key: true
      t.string :trust_framework
      t.datetime :time

      t.timestamps
    end
  end
end
