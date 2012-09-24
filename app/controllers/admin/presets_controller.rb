module Admin
	class PresetsController < ApplicationController

  	inherit_resources

  	def students  		
  		@preset_hash =  Preset.load_presets_hash(Preset::PRESETS[:student]) 
  	end

  	def locale
      @preset_hash =  Preset.load_presets_hash(Preset::PRESETS[:locale]) 
  	end

  	def update_presets

      ActiveRecord::Base.transaction do
        params[:presets].each do |preset|
          Preset.send(:set, preset[0], preset[1])
        end
      end

  		redirect_to :back, :notice => 'Presets updated'
      # preset_names = []
      # preset_contents = {}
      # params[:presets].each do |preset_params|
      #     preset_names.append "#{preset_params[1][:name].downcase}"
      #     preset_contents[preset_params[1][:id].to_i] = preset_params[1][:content]
      # end
      
      # @presets = Preset.where(:name => preset_names)
      
      # ActiveRecord::Base.transaction do
      #   @presets.each do |preset|
      #     Preset.send(:set, preset.name, preset_contents[preset.id])
      #   end
      # end
    
		end
	
	end
end