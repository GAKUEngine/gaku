require 'spec_helper'

describe 'Student Versioning' do

  let(:student) do
    create(:student, name: 'Vassil', middle_name: 'Anastasov', surname: 'Kalkov', foreign_id_code: '96')
  end

  subject { Gaku::Versioning::StudentVersion.last }

  it 'saves soft delete', versioning: true do
    expect do
      student.soft_delete
    end.to change(Gaku::Versioning::StudentVersion, :count).by(1)

    expect(subject.human_changes['deleted']).to eq [false, true]
  end

  it 'saves foreign_id_code changes', versioning: true do

    old_foreign_id_code = student.foreign_id_code

    expect do
      student.foreign_id_code = '1'
      student.save
    end.to change(Gaku::Versioning::StudentVersion, :count).by(1)

    expect(subject.human_changes['foreign_id_code']).to eq [old_foreign_id_code, student.foreign_id_code]
  end

  it 'saves names changes', versioning: true do
    old_name = student.name
    old_middle_name = student.middle_name
    old_surname = student.surname

    expect do
      student.name = 'Changed Name'
      student.middle_name = 'Changed MiddleName'
      student.surname = 'Changed SurName'
      student.save
    end.to change(Gaku::Versioning::StudentVersion, :count).by(1)

    expect(subject.human_changes['name']).to eq [old_name, student.name]
    expect(subject.human_changes['middle_name']).to eq [old_middle_name, student.middle_name]
    expect(subject.human_changes['surname']).to eq [old_surname, student.surname]
  end

  it 'saves enrollment_status_code changes', versioning: true do
    enrollment_status1 = create(:enrollment_status)
    enrollment_status2 = create(:enrollment_status, code: 'changed_one', name: 'Changed One')
    student.enrollment_status_code = enrollment_status1.code
    student.save

    expect do
      student.enrollment_status_code = enrollment_status2.code
      student.save
    end.to change(Gaku::Versioning::StudentVersion, :count).by(1)

    expect { subject.human_changes[:enrollment_status].to eq [enrollment_status1.to_s, enrollment_status2.to_s] }
  end

  it 'saves commute_method_type changes', versioning: true do
    commute_method_type1 = create(:commute_method_type)
    commute_method_type2 = create(:commute_method_type, name: 'Changed One')
    student.commute_method_type = commute_method_type1
    student.save

    expect do
      student.commute_method_type = commute_method_type2
      student.save
    end.to change(Gaku::Versioning::StudentVersion, :count).by(1)

    expect { subject.human_changes[:commute_method_type].to eq [commute_method_type1.to_s, commute_method_type2.to_s] }
  end

  it 'saves scholarship_status changes', versioning: true do
    scholarship_status1 = create(:scholarship_status)
    scholarship_status2 = create(:scholarship_status, name: 'Changed One')
    student.scholarship_status = scholarship_status1
    student.save

    expect do
      student.scholarship_status = scholarship_status2
      student.save
    end.to change(Gaku::Versioning::StudentVersion, :count).by(1)

    expect { subject.human_changes[:scholarship_status].to eq [scholarship_status1.to_s, scholarship_status2.to_s] }
  end

end
