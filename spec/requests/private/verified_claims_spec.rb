require 'rails_helper'

RSpec.describe "::Private::VerifiedClaims", type: :request do
  describe "GET //private/verified_claims" do
    # it "works! (now write some real specs)" do
    #   get _private_verified_claims_index_path
    #   expect(response).to have_http_status(200)
    # end

    let(:ekyc_user) { create(:ekyc_user) }
    let(:ekyc_user_id) { ekyc_user.uuid }
    let(:params) {
      {
        "name": "アップデート",
        "given_name": nil,
        "family_name": "sssssssss",
        "birthdate": "2020-01-24",
        "address": {
          "street_address": "null",
          "locality": "ppppp",
          "region": "静岡",
          "postal_code": "222-9999",
          "country": "日本"
        },
        "process": {
          "trust_framework": "ssa",
          "time": "2000-11-30 06:45",
          "evidences": [
            {
              "time": "1990-06-11 08:00",
              "evidence_type": "document",
              "check_method": "vri",
              "document_type": "jp_individual_number_card"
            },
            {
              "time": "1990-06-11 08:00",
              "evidence_type": "document",
              "check_method": "vri",
              "document_type": "jp_individual_number_card"
            },
            {
              "time": "1990-06-11 08:00",
              "evidence_type": "document",
              "check_method": "vri",
              "document_type": "jp_individual_number_card"
            }
          ]
        }
      }
    }

    before do
      create(:verified_claim, :with_claim_address, :with_verification_process, ekyc_user: ekyc_user)
    end

    # it 'ステータスコード200を返すこと' do
    #   put private_user_verified_claims_path(ekyc_user_id), params: params
    #   expect(response).to have_http_status(200)
    # end

    it 'アップデート' do
      put private_user_verified_claims_path(ekyc_user_id), params: params
      expect(response).to have_http_status(200)
    end

    it 'レスポンスボディ' do
      put private_user_verified_claims_path(ekyc_user_id), params: params
      json = JSON.parse(response.body)
      expect(json['name']).to eq params[:name]
    end

    it 'delete' do
      delete private_user_verified_claims_path(ekyc_user_id), params: params
      expect(response).to have_http_status(204)
    end
  end
end
