if %w(development test).include? Rails.env
  unless ENV['I18N'] == 0
  	module I18n
  	  def self.just_raise_that_exception(exception, key, locale, options)
  	    raise [exception, key].inspect
  	  end
  	end

  	I18n.exception_handler = :just_raise_that_exception
  end
end
