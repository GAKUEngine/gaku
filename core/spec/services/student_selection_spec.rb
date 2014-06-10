require 'spec_helper_models'

describe Gaku::StudentSelection do

  let(:student) { build(:student) }

  it 'instantializes' do
    expect(described_class.new(student).student).to eq student
  end

  it 'adds student to selection' do
    described_class.new(student).add
    expect($redis.lrange(:student_selection, 0, -1))
      .to eq ([{ id: "#{student.id}", full_name: "#{student.surname} #{student.name}" }.to_json])
  end

  it 'removes student to selection' do
    described_class.new(student).add

    described_class.new(student).remove
    expect($redis.lrange(:student_selection, 0, -1)).to eq []
  end

end
