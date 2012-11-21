module I18n
  def self.just_raise_that_exception(exception, key, locale, options)
    raise exception
  end
end
 
I18n.exception_handler = :just_raise_that_exception