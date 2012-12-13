field_order = ["surname", "name"]
  
content = CSV.generate do |csv|
  csv << translate_fields(field_order)
  @students.each do |student|
    csv << student.attributes.values_at(*field_order)
  end
end
