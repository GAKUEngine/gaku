module Gaku
  module Admin
  	class PresetsController < Admin::BaseController

      authorize_resource :class => false

    	inherit_resources

    	def students
        @countries = Country.all.sort_by(&:name).collect { |s| [s.name, s.id] }
      	@preset_hash = Preset.load_presets_hash(Preset::PRESETS[:student])
      end

    	def locale
        @preset_hash = Preset.load_presets_hash(Preset::PRESETS[:locale])
    	end

      def grading
        @preset_hash = Preset.load_presets_hash(Preset::PRESETS[:grading])
      end

      def pagination
        @preset_hash = Preset.load_presets_hash(Preset::PRESETS[:pagination])
      end

      def output_formats
        @preset_hash = Preset.load_presets_hash(Preset::PRESETS[:output_formats])
      end

    	def update_presets
        Preset.save_presets(params[:presets])
    		redirect_to :back, :notice => t(:'notice.updated', :resource => t(:'preset.plural'))
  		end

  	end
  end
end
