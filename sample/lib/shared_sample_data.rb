@country = Gaku::Country.where(
                                name: 'Japan',
                                iso3: 'JPN',
                                iso: 'JP',
                                iso_name: 'JAPAN',
                                numcode: '392'
                              ).first_or_create!

@state = Gaku::State.where(name: Faker::Address.us_state, country_iso: @country.iso).first_or_create!

@mobile_phone = Gaku::ContactType.where(name: 'Mobile Phone').first_or_create!
@home_phone = Gaku::ContactType.where(name: 'Home Phone').first_or_create!
@email = Gaku::ContactType.where(name: 'Email').first_or_create!
@enrollment_status = Gaku::EnrollmentStatus.where(code: 'admitted').first.try(:code)
@enrollment_status_applicant = Gaku::EnrollmentStatus.where(code: 'applicant').first.try(:code)
@commute_method_type = Gaku::CommuteMethodType.create!(name: 'Superbike')
@scholarship_status = Gaku::ScholarshipStatus.create!(name: 'Charity')

@john_doe = {
  name: 'John',
  surname: 'Doe',
  birth_date: Date.new(1983, 10, 5),
  enrollment_status_code: @enrollment_status
}

def batch_create(count)
  ActiveRecord::Base.transaction do
    if Rails.env.development?
      bar = RakeProgressbar.new(count)
      count.times do
        bar.inc
        yield
      end
      bar.finished
    else
      count.times { yield }
    end
  end
end

def random_person
  {
    name: Faker::Name.first_name,
    middle_name: Faker::Name.first_name,
    surname: Faker::Name.last_name,
    birth_date: Date.today - rand(1000)
  }
end

def random_home_phone
  {
    data: Faker::PhoneNumber.phone_number,
    contact_type_id: @home_phone.id
  }
end

def random_mobile_phone
  {
    data: Faker::PhoneNumber.phone_number,
    contact_type_id: @mobile_phone.id
  }
end

def random_email
  {
    data: Faker::Internet.email,
    contact_type_id: @email.id
  }
end

def random_note
  {
    title: Faker::Lorem.word,
    content: Faker::Lorem.sentence
  }
end

def random_address
  {
    address1: Faker::Address.street_address,
    address2: Faker::Address.street_address,
    title: 'Home address',
    zipcode: '452-0813',
    city: 'Nagoya',
    country: @country,
    state: @state
  }
end

def create_student_with_full_info(predefined_student = nil)
  if predefined_student
    student = Gaku::Student.where(predefined_student).first_or_create!
  else
    random_student = random_person.merge(enrollment_status_code: @enrollment_status)
    student = Gaku::Student.where(random_student).first_or_create!
  end

  student.addresses.where(random_address).first_or_create!

  [random_email, random_home_phone, random_mobile_phone].each do |params|
    Gaku::ContactCreation.new(params.merge(contactable: student)).save!
  end

  student.notes.where(random_note).first_or_create!
  student.notes.where(random_note).first_or_create!

  guardian = Gaku::Guardian.where(random_person).first_or_create!
  guardian.addresses.where(random_address).first_or_create!

  [random_email, random_home_phone, random_mobile_phone].each do |params|
    Gaku::ContactCreation.new(params.merge(contactable: guardian)).save!
  end

  student.guardians << guardian
end

def create_non_active_student(predefined_student = nil)
  if predefined_student
    Gaku::Student.where(predefined_student).first_or_create!
  else
    random_student = random_person.merge(enrollment_status_code: @enrollment_status_applicant)
    Gaku::Student.where(random_student).first_or_create!
  end
end

def create_teacher_with_full_info(predefined_teacher = nil)
  if predefined_teacher
    teacher = Gaku::Teacher.where(predefined_teacher).first_or_create!
  else
    random_teacher = random_person
    teacher = Gaku::Teacher.where(random_teacher).first_or_create!
  end

  teacher.addresses.create!(random_address)

  [random_email, random_home_phone, random_mobile_phone].each do |params|
    Gaku::ContactCreation.new(params.merge(contactable: teacher)).save!
  end

  teacher.notes.create!(random_note)
  teacher.notes.create!(random_note)
end
