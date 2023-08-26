class VerifiedClaim < ApplicationRecord
  belongs_to :ekyc_user
  has_one :claim_address, dependent: :destroy

  # accepts_nested_attributes_for :claim_address, update_only: true, allow_destroy: true
  # accepts_nested_attributes_for :claim_address, update_only: true
  accepts_nested_attributes_for :claim_address

  has_one :verification_process, dependent: :destroy

  # accepts_nested_attributes_for :verification_process, update_only: true, allow_destroy: true
  # accepts_nested_attributes_for :verification_process, update_only: true
  accepts_nested_attributes_for :verification_process

  # dependent: :destroyしていれば、allow_destroy: true がなくても親とともに削除してくれる
  # update_only: true なしだといったんレコードが削除されてから INSERT される
  # update_only: true ない場合　validation にひっかったりした場合 rollback されて削除などは行われない
end
