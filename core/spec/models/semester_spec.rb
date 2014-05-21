require 'spec_helper_models'

describe Gaku::Semester do
  let(:school_year) do
    create(:school_year, starting: Date.parse('2013-3-8'), ending: Date.parse('2014-11-8'))
  end

  describe 'associations' do
    it { should have_many :semester_connectors }
    it { should have_many(:class_groups).through(:semester_connectors).source(:semesterable) }
    it { should have_many(:courses).through(:semester_connectors).source(:semesterable) }

    it { should belong_to :school_year }
  end

  describe 'validations' do
    it { should validate_presence_of :starting }
    it { should validate_presence_of :ending }

    context 'custom validations' do
      before do
      end

      it 'validation error for ending before after' do
        school_year
        semester = school_year.semesters.create starting: Date.parse('2013-4-8'), ending: Date.parse('2013-4-7')
        semester.valid?.should be_false
        semester.should have(1).error_on(:base)
      end

      it 'validation error on not between school year starting and ending' do
        school_year
        semester = school_year.semesters.create starting: Date.parse('2013-3-7'), ending: Date.parse('2014-11-9')
        semester.valid?.should be_false
        semester.should have(1).error_on(:base)
      end
    end
  end

  let(:active_semester) { create(:active_semester) }
  let(:upcomming_semester) { create(:upcomming_semester) }
  let(:ended_semester) { create(:ended_semester) }

  describe 'scopes' do
    it 'active' do
      active_semester
      expect(described_class.active).to eq [active_semester]
    end

    it 'upcomming' do
      upcomming_semester
      expect(described_class.upcomming).to eq [upcomming_semester]
    end
  end

  it '#active?' do
    active_semester
    expect(active_semester.active?).to be true
  end

  it '#upcomming?' do
    upcomming_semester
    expect(upcomming_semester.upcomming?).to be true
  end

  it '#ended?' do
    ended_semester
    expect(ended_semester.ended?).to be true
  end

end
