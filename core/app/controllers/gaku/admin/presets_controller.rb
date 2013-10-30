module Gaku
  class Admin::PresetsController < Admin::BaseController

    respond_to :html, only: %i( index edit update )
    before_action :set_preset, except: :index

    def index
      @presets = Preset.all
      @count = Preset.count
      respond_with @presets
    end

    def edit
      @per_page_values = [10, 25, 50, 100]
      @countries = Country.all
    end

    def update
      @preset.update(preset_params)
      respond_with @preset, location: [:edit, :admin, @preset]
    end

    private

    def preset_params
      params.require(:preset).permit(preset_attr)
    end

    def preset_attr
      [
        :name, :default, :active, :locale, :names_order,
        pagination: pagination_attr,
        grading: grading_attr,
        person: person_attr,
        address: address_attr,
        export_formats: export_formats_attr,
        chooser_fields: chooser_fields_attr
      ]
    end

    def pagination_attr
      %i( default students teachers changes )
    end

    def grading_attr
      %i( method scheme )
    end

    def person_attr
      %i( gender )
    end

    def address_attr
      %i( country state city )
    end

    def export_formats_attr
      %i( documents printables spreadsheets )
    end

    def chooser_fields_attr
      %i( surname name birth_date sex class_name seat_number admitted_on primary_address primary_contact assignments )
    end

    def set_preset
      @preset = Preset.find(params[:id])
    end

  end
end
