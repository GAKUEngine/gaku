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

class Preset < ActiveRecord::Base
  attr_accessible :content, :name

  PRESETS = {
  	:student => ['students_gender', 'address_country', 'address_state', 'address_city'],
  	:locale => ['language']
  }

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


end
