class Gaku::Api::StudentCreateService
  prepend SimpleCommand
  attr_accessor :student_params

  def initialize(student_params)
    @student_params = student_params
  end

  def call
    student = Gaku::Student.where(required_attributes).first_or_create(student_params)

    if student.persisted?
      return student
    else
      errors.add(:base, student.errors.full_messages)
    end

  end

  def required_attributes
    {
      name: student_params[:name],
      surname: student_params[:surname],
      birth_date: student_params[:birth_date]
    }
  end
end
