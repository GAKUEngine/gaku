module Gaku
  module Api
    module V1
      class GuardiansController < BaseController
        before_action :set_guardian, only: :show


        def index
          @guardians = Guardian.includes(:primary_contact, :primary_address).all
          collection_respond_to @guardians, root: :guardians
        end

        def show
          member_respond_to @guardian
        end

        def create
          create_service = GuardianCreateService.call(guardian_params)
          if create_service.success?
            member_respond_to create_service.result
          else
            render_service_errors(create_service.errors[:base])
          end
        end

        private

        def set_guardian
          @guardian = Guardian.find(params[:id])
        end

        def guardian_params
          params.permit(guardian_attributes)
        end

        def guardian_attributes
          %i(
            name surname name_reading surname_reading middle_name middle_name_reading
            birth_date gender contact
          )
        end

      end
    end
  end
end
