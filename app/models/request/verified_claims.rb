module Request
  module VerifiedClaims
    class CreateOrUpdate
      include ActiveModel::Model

      attr_accessor :address, :process, :evidences

      attr_accessor :name, :given_name, :family_name, :birthdate, :ekyc_user_id
      attr_accessor :street_address, :locality, :region, :postal_code, :country
      attr_accessor :trust_framework, :time
      attr_accessor :time, :evidence_type, :check_method, :document_type

      validates :name, length: { maximum: 255 }
      validates :given_name, length: { maximum: 255 }
      validates :family_name, length: { maximum: 255 }
      validates :birthdate, format: { with: /\A[0-9]{4}-[0-9]{2}-[0-9]{2}\z/ }, allow_nil: true

      validate :validation_for_each_attrs

      def initialize(params:, user_id:)
        super(params.slice(:name, :given_name, :family_name, :birthdate))
        debugger
        @address = Address.new(params[:address])
        @process = Process.new(params[:process].slice(:trust_framework, :time))
        @evidences = Evidence.new(params[:process][:evidences][0])
      end

      def validation_for_each_attrs
        error_having_object = [address, process, evidences].select(&:invalid?)
        return if error_having_object.empty?
        error_having_object.each do |obj|
          obj.errors.details.keys.each do |field|
            obj.errors.details[field].each_with_index do |error, i|
              errors.add(field, error[:error], message: obj.errors.messages[field][i])
            end
          end
        end
      end

      class Address
        include ActiveModel::Model

        attr_accessor :street_address, :locality, :region, :postal_code, :country

        validates :street_address, length: { maximum: 255 }
        validates :locality, length: { maximum: 255 }
        validates :region, length: { maximum: 255 }
        validates :postal_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/ }, allow_nil: true
        validates :country, length: { maximum: 255 }
        
      end

      class Process
        include ActiveModel::Model

        attr_accessor :trust_framework, :time

        validates :trust_framework, presence: true, inclusion: { in: %w(ssa), allow_nil: true }
      end

      class Evidence
        include ActiveModel::Model

        attr_accessor :time, :evidence_type, :check_method, :document_type

        validates :evidence_type, inclusion: { in: %w(document, electronic_signature), allow_nil: true }, allow_nil: true
        validates :check_method, inclusion: { in: %w(vri vcrypt), allow_nil: true }, allow_nil: true
        validates :document_type, inclusion: { in: %w(jp_individual_number_card), allow_nil: true }, if: :document?
        validates :document_type, inclusion: { in: [nil] }, unless: :document?

        private

        def document?
          evidence_type == 'document'
        end
      end
    end
  end
end