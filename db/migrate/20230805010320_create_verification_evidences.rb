class CreateVerificationEvidences < ActiveRecord::Migration[6.0]
  def change
    create_table :verification_evidences do |t|
      t.references :verification_process, null: false, foreign_key: true
      t.datetime :time
      t.string :evidence_type
      t.string :check_method
      t.string :document_type

      t.timestamps
    end
  end
end
