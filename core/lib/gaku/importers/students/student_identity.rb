module Gaku::Importers::Students::StudentIdentity
  def normalize_id_num(id_number)
    if id_number.to_i == 0 # ID is alphanumeric
      return id_number.to_s
    else # ID number is a number, defaulted to float from sheet data
      return id_number.to_i.to_s
    end
  end

  def find_student_by_student_ids(student_id_number, student_foreign_id_number = nil)
    student =  Gaku::Student.where(
      student_id_number: normalize_id_num(student_id_number)).first
    return student unless student.nil?
    Gaku::Student.where(
      student_foreign_id_number: normalize_id_num(student_foreign_id_number)).first
  end
end
