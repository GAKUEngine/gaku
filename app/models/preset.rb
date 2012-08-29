class Preset < ActiveRecord::Base
  attr_accessible :content, :name

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
		preset  = Preset.first_or_create(:name => key)
		preset.update_attribute(:content, value.to_yaml)
	end

	def self.get(key)
		preset = 	Preset.where(:name => key).first
		preset.nil? ? nil : YAML.load(preset.content) 
	end


end
