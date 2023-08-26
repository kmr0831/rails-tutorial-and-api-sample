class Private::VerifiedClaimsController < ApplicationController

  before_action :set_user
  before_action :exist_user

  def show
  end

  def update
    # return head :not_found if @ekyc_user.nil?

    verified_claim = VerifiedClaim.find_or_initialize_by(ekyc_user_id: @ekyc_user.id)
    debugger
    verified_claim.update!(put_verified_claim_params)
    # verified_claim.assign_attributes(put_verified_claim_params)
    # verified_claim.save!
    
    render json: verified_claim, serializer: VerifiedClaimSerializer
  end

  def destroy
    debugger
    verified_claim = VerifiedClaim.find_by!(ekyc_user_id: @ekyc_user.id)
    
    verified_claim.destroy!
    head 204

    # VerifiedClaim がないのに削除しようとしたとき
    # verified_claim = VerifiedClaim.find_byの場合 verified_claim は nil となり Completed 500 Internal Server Error
    # verified_claim = VerifiedClaim.find_by!の場合 例外を起こして Completed 404 Not Found
  end

  private

  def exist_user
    EkycUser.find_by!(uuid: params[:user_id])
  end

  def set_user
    @ekyc_user = EkycUser.find_by(uuid: params[:user_id])
  end

  def put_verified_claim_params
    # params[:claim_address_attributes] = params.delete(:address)
    # params[:verification_process_attributes] = params.delete(:process)
    # params[:verification_process_attributes][:verification_evidences_attributes] = params[:verification_process_attributes].delete(:evidences).to_a

    # params.permit(
    #   :name, :given_name, :family_name, :birthdate,
    #   claim_address_attributes: [:street_address, :locality, :region, :postal_code, :country],
    #   verification_process_attributes: [:trust_framework, :time, { verification_evidences_attributes: [:time, :evidence_type, :check_method, :document_typ] }]
    # )

    origin_verified_claims_params = params.permit(
      :name, :given_name, :family_name, :birthdate,
      address: [:street_address, :locality, :region, :postal_code, :country],
      process: [:trust_framework, :time, { evidences: [:time, :evidence_type, :check_method, :document_type] }]
    )
    
    verified_claims_params = origin_verified_claims_params.slice(:name, :given_name, :family_name, :birthdate)
    verified_claims_params[:claim_address_attributes] = origin_verified_claims_params.delete(:address)
    verified_claims_params[:verification_process_attributes] = origin_verified_claims_params[:process].slice(:trust_framework, :time)
    verified_claims_params[:verification_process_attributes][:verification_evidences_attributes] = origin_verified_claims_params[:process][:evidences]
    verified_claims_params
  end

end
