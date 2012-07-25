module SheetHelper
  def translate_fields(fields)
    translated_fields = []
    fields.each do |field|
      translated_fields << I18n.t("fields." + field)
    end

    return translated_fields
  end
end
