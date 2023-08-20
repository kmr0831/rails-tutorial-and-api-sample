class Private::VerifiedClaimsController < ApplicationController

  before_action :exist_user
  before_action :validate_request

  def show
  end

  def update
    ekyc_user = EkycUser.find_by(uuid: params[:user_id])
    if VerifiedClaim.exists?(ekyc_user_id: ekyc_user.id)
      vc = VerifiedClaim.find_by(ekyc_user_id: ekyc_user.id)
      vc.update(put_verified_claim_params.slice(:name, :given_name, :family_name, :birthdate))
      vc.claim_address.update(put_verified_claim_params[:address])
      vc.verification_process.update!(put_verified_claim_params[:process].slice(:trust_framework, :time))
      vc.verification_process.verification_evidences.update(put_verified_claim_params[:process][:evidences][0])
    else
      vc = ekyc_user.build_verified_claim(put_verified_claim_params.slice(:name, :given_name, :family_name, :birthdate))
      vca = vc.build_claim_address(put_verified_claim_params[:address])
      vp = vc.build_verification_process(put_verified_claim_params[:process].slice(:trust_framework, :time))
      ve = vp.verification_evidences.build(put_verified_claim_params[:process][:evidences])
      vc.save!
    end
    
    
    # vc = ekyc_user.build_verified_claim
    # vca = vc.build_claim_address
    # vp = vc.build_verification_process
    # ve = vp.verification_evidences.build

    # verified_claim = VerifiedClaim.find_or_initialize_by(ekyc_user_id: ekyc_user.id)
    # verified_claim.assign_attributes(put_verified_claim_params)
    # debugger
    # verified_claim.save!
    render json: vc, serializer: VerifiedClaimSerializer
  end

  def destroy
    verified_claim = VerifiedClaim.find_by(ekyc_user_id: @ekyc_user.id)
    verified_claim.destroy!
    head 204
  end

  private

  def exist_user
    EkycUser.find_by!(uuid: params[:user_id])
  end

  def validate_request
    verified_claim_req = Request::VerifiedClaims::CreateOrUpdate.new(params: put_verified_claim_params, user_id: params[:user_id])
    debugger
    verified_claim_req.validate!
  end

  def put_verified_claim_params
    params.permit(
      :name, :given_name, :family_name, :birthdate,
      address: [:street_address, :locality, :region, :postal_code, :country],
      process: [
        :trust_framework,
        :time,
        {
          evidences: [:time, :evidence_type, :check_method, :document_type]
        }
      ]
    )
  end

end
