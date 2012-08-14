# == Schema Information
#
# Table name: contacts
#
#  id              :integer          not null, primary key
#  data            :string(255)
#  details         :text
#  is_primary      :boolean          default(FALSE)
#  is_emergency    :boolean          default(FALSE)
#  contact_type_id :integer
#  student_id      :integer
#  guardian_id     :integer
#  faculty_id      :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

FactoryGirl.define do
  factory :contact do
    data "gaku@example.com"
    association(:contact_type)
    details "My email"
  end
end
