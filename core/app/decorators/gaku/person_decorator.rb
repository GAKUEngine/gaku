module Gaku
  class PersonDecorator < Draper::Decorator

    def sex_and_birth
      [h.gender(object), object.birth_date.to_s].reject(&:empty?).join(', ')
    end

    # returns full name complete with formatting [if any]
    def formatted_name
      student_names
    end

    def formatted_name_reading
      student_names reading: true
    end

    def full_name
      "#{object.surname} #{object.name}"
    end

    def full_name_reading
      student_names without_formating: true, reading: true
    end

    def student_names(options = {})
      @names_preset ||= Gaku::Preset.names
      preset = @names_preset

      if options[:without_formating]
        preset_without_format = ''
        preset.gsub(/%(\w+)/) { |n|  preset_without_format << n + ' ' }
        preset = preset_without_format.strip
      end

      if options[:reading] && object.name_reading.blank? &&
        object.surname_reading.blank? &&
        object.middle_name_reading.blank?
        return ''
      end

      reading = options[:reading]
      return reading ? object.phonetic_reading : object.to_s if preset.blank?
      result = preset.gsub(/%(\w+)/) do |name|
        case name
        when '%first' then proper_name(:name, reading)
        when '%middle' then proper_name(:middle_name, reading)
        when '%last' then proper_name(:surname, reading)
        end
      end
      return result.gsub(/[^[[:word:]]\s]/, '').gsub(/\s+/, ' ').strip if object.middle_name.blank?
      result.gsub(/\s+/, ' ').strip
    end

    private

    def proper_name(attribute, reading)
      reading ? object.send(attribute.to_s + '_reading') : object.send(attribute)
    end
  end
end
