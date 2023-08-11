class Private::VerifiedClaimsController < ApplicationController

  before_action :set_user

  def show
  end

  def update
    return head :not_found if @ekyc_user.nil?

    verified_claim = VerifiedClaim.find_or_initialize_by(ekyc_user_id: @ekyc_user.id)
    verified_claim.assign_attributes(put_verified_claim_params)
    verified_claim.save!
    render json: verified_claim, serializer: VerifiedClaimSerializer
  end

  def destroy
    verified_claim = VerifiedClaim.find_by(ekyc_user_id: @ekyc_user.id)
    verified_claim.destroy!
    head 204
  end

  private

  def set_user
    @ekyc_user = EkycUser.find_by(uuid: params[:user_id])
  end

  def put_verified_claim_params
    params[:claim_address_attributes] = params.delete(:address)
    params[:verification_process_attributes] = params.delete(:process)
    params[:verification_process_attributes][:verification_evidences_attributes] = params[:verification_process_attributes].delete(:evidences).to_a
    
    params.permit(
      :name,
      :given_name,
      :family_name,
      :birthdate,
      claim_address_attributes: [
        :street_address,
        :locality,
        :region,
        :postal_code,
        :country
      ],
      verification_process_attributes: [
        :trust_framework,
        :time,
        {
          verification_evidences_attributes: [
            :time,
            :evidence_type,
            :check_method,
            :document_type
          ]
        }
      ]
    )
  end

end
