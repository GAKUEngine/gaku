module Gaku
  module Admin
  	class PresetsController < Admin::BaseController

      authorize_resource :class => false

    	inherit_resources

    	def students
      	@preset_hash = Preset.load_presets_hash(Preset::PRESETS[:student])
      end

    	def locale
        @preset_hash = Preset.load_presets_hash(Preset::PRESETS[:locale])
    	end

      def grading
        @preset_hash = Preset.load_presets_hash(Preset::PRESETS[:grading])
      end

    	def update_presets
        Preset.save_presets(params[:presets])
    		redirect_to :back, :notice => t(:'notice.updated', :resource => t(:'preset.plural'))
  		end

  	end
  end
end
