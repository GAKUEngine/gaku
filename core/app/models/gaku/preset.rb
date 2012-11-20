# == Schema Information
#
# Table name: presets
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  content    :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
module Gaku
	class Preset < ActiveRecord::Base
	  attr_accessible :content, :name

	  PRESETS = {
	  	:student => ['students_gender', 'address_country', 'address_state', 'address_city'],
	  	:locale => ['language'],
	  	:grading => ['grading_method', 'grading_scheme']
	  }

	  def self.save_presets(params)
	  	ActiveRecord::Base.transaction do
        params.each do |preset|
          self.send(:set, preset[0], preset[1])
        end
      end
    end



	  def self.method_missing(method, *args, &block)
			return self.send method, *args, &block if self.respond_to? method  
			
			method_name = method.to_s
			if method_name =~ /=/
				return self.set method_name.gsub('=', ''), args.first 
			else
				return self.get method_name
			end
		end


		private
		
		def self.set(key, value)
			preset = Preset.where(:name => key).first_or_initialize
			preset.update_attribute(:content, value.to_yaml)
		end

		def self.get(key)
			preset = 	Preset.where(:name => key).first
			preset.nil? ? nil : YAML.load(preset.content) 
		end

		def self.load_or_create(presets)
			@presets = Preset.where(:name => presets)
			if presets.count == @presets.length
				@presets
			else
				presets.each do |preset|
					Preset.where(:name => preset).first_or_create
				end
				@presets = Preset.where(:name => presets)
			end
		end

		def self.load_presets_hash(presets)
			presets_hash = {}
			@presets = Preset.where(:name => presets)
			@presets.each do |preset|
				presets_hash[preset.name.to_sym] = YAML.load(preset.content) rescue nil
			end
			return presets_hash
		end
	end
end
