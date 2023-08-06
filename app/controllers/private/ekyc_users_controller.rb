class Private::EkycUsersController < ApplicationController
  def update
    @ekyc_user = EkycUser.find_by(uuid: params[:user_id])
    debugger
    if @ekyc_user.verified_claim
      @ekyc_user.verified_claim.update!(put_verified_claim_params)
    else
      @claim = VerifiedClaim.create!(put_verified_claim_params)
    end
  end

  private
    def put_verified_claim_params
      request_verified_claims_params, request_verification_process_params = params.require(%i[verified_claims verification_process])
      request_params = ActionController::Parameters.new({
        verified_claims: request_verified_claims_params.permit(:name, :given_name, :family_name, :birthdate, address:[:street_address, :locality, :region, :postal_code, :country]),
        verification_process: request_verification_process_params.permit(:trust_framework, :time, evidences: [:time, :evidence_type, :check_method, :document_type])
      }).permit!
      
      verified_claims_params = {
        ekyc_user_id: @ekyc_user.id,
        name: request_params[:verified_claims][:name], 
        given_name: request_params[:verified_claims][:given_name], 
        family_name: request_params[:verified_claims][:family_name], 
        birthdate: request_params[:verified_claims][:birthdate]
      }
      
      verified_claims_params[:claim_address_attributes] = {
        street_address: request_params[:verified_claims][:address][:street_address],
        locality: request_params[:verified_claims][:address][:locality],
        region: request_params[:verified_claims][:address][:region],
        postal_code: request_params[:verified_claims][:address][:postal_code],
        country: request_params[:verified_claims][:address][:country]
      }

      verified_claims_params[:verification_process_attributes] = {
        trust_framework: request_params[:verification_process][:trust_framework], 
        time: request_params[:verification_process][:time]
      }

      verified_claims_params[:verification_process_attributes][:verification_evidences_attributes] = [{
        time: request_params[:verification_process][:evidences][0][:time],
        evidence_type: request_params[:verification_process][:evidences][0][:evidence_type],
        check_method: request_params[:verification_process][:evidences][0][:check_method],
        document_type: request_params[:verification_process][:evidences][0][:document_type]
      }]

      verified_claims_params
    end
end
