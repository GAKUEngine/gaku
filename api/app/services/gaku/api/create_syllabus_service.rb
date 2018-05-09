class Gaku::Api::CreateSyllabusService
  prepend SimpleCommand

  attr_accessor :params, :user

  def initialize(user, params = {})
    @user = user
    @params = params
  end

  def call
    @syllabus = Gaku::Syllabus.new(params)
    if @syllabus.save
      if user.role?('teacher')
        @syllabus.teachers << user.teacher
      end
      return @syllabus
    else
      errors.add(:base, 'Syllabus creation failed')
    end
    nil
  end



end
