@country = Gaku::Country.where(  name: '日本',
                                 iso3: 'JPN',
                                 iso: 'JP',
                                 iso_name: 'JAPAN',
                                 numcode: '392'
                              ).first_or_create!

@mobile_phone = Gaku::ContactType.where(name: 'Mobile Phone').first_or_create!
@home_phone = Gaku::ContactType.where(name: 'Home Phone').first_or_create!
@email = Gaku::ContactType.where(name: 'Email').first_or_create!
@enrollment_status = Gaku::EnrollmentStatus.where(code: 'admitted').first.try(:code)
@commute_method_type = Gaku::CommuteMethodType.create!(name: 'Superbike')
@scholarship_status = Gaku::ScholarshipStatus.create!(name: 'Charity')

@john_doe = {
  name: 'John',
  surname: 'Doe',
  birth_date: Date.new(1983,10,5),
  enrollment_status_code: @enrollment_status
}

def batch_create(count)
  ActiveRecord::Base.transaction do
    bar = RakeProgressbar.new(count)
    count.times do
      bar.inc
      yield
    end
    bar.finished
  end
end

def random_person
  {
    name: Faker::Name.first_name,
    middle_name: Faker::Name.first_name,
    surname: Faker::Name.last_name,
    birth_date: Date.today-rand(1000)
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
    country: @country
  }
end

def create_student_with_full_info(predefined_student=nil)
  if predefined_student
    student = Gaku::Student.where(predefined_student).first_or_create!
  else
    random_student = random_person.merge(enrollment_status_code: @enrollment_status)
    student = Gaku::Student.where(random_student).first_or_create!
  end

  student.addresses.where(random_address).first_or_create!
  student.contacts.where(random_email).first_or_create!
  student.contacts.where(random_home_phone).first_or_create!
  student.contacts.where(random_mobile_phone).first_or_create!
  student.notes.where(random_note).first_or_create!
  student.notes.where(random_note).first_or_create!

  #guardian
  guardian = Gaku::Guardian.where(random_person).first_or_create!
  guardian.addresses.where(random_address).first_or_create!
  guardian.contacts.where(random_email).first_or_create!
  guardian.contacts.where(random_home_phone).first_or_create!
  guardian.contacts.where(random_mobile_phone).first_or_create!
  #guardian.notes.where(random_note).first_or_create!
  #guardian.notes.where(random_note).first_or_create!

  student.guardians << guardian
end