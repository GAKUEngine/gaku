module I18n
  module Backend
    class Simple
      # Monkey-patch-in localization debugging.. ( see: http://www.unixgods.org/~tilo/Rails/which_l10n_strings_is_rails_trying_to_lookup.html )
      # Enable with ENV['I18N_DEBUG']=1 on the command line in server startup, or ./config/environments/*.rb file.
      #
      def lookup(locale, key, scope = [], options = {})
        init_translations unless initialized?
        keys = I18n.normalize_keys(locale, key, scope, options[:separator])

        puts "I18N keys: #{keys}"  if ENV['I18N_DEBUG']

        keys.inject(translations) do |result, _key|
          _key = _key.to_sym
          return nil unless result.is_a?(Hash) && result.has_key?(_key)
          result = result[_key]
          result = resolve(locale, _key, result, options.merge(:scope => nil)) if result.is_a?(Symbol)

          puts "\t\t => " + result.to_s + "\n" if ENV['I18N_DEBUG'] && (result.class == String)

          result
        end
      end
    end
  end
end