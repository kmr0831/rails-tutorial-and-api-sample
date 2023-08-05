class RenamePosttalCodeColumnToClaimAddresses < ActiveRecord::Migration[6.0]
  def change
    rename_column :claim_addresses, :posttal_code, :postal_code
  end
end
