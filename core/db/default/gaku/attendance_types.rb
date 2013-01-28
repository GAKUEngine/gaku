types = [

  {
    :name => "Present",
    :color_code => "#006e54",
    :counted_absent => false,
    :disable_credit => false,
    :credit_rate => 1.00,
    :auto_credit => false
  },

  {
    :name => "Present for Credit",
    :color_code => "#00a497",
    :counted_absent => false,
    :disable_credit => false,
    :credit_rate => 1.00,
    :auto_credit => true
  },

  {
    :name => "Excused",
    :color_code => "#2c4f54",
    :counted_absent => false,
    :disable_credit => false,
    :credit_rate => 1.00,
    :auto_credit => true
  },

  {
    :name => "Illness",
    :color_code => "#4d4398",
    :counted_absent => true,
    :disable_credit => false,
    :credit_rate => 0.80,
    :auto_credit => true
  },

  {
    :name => "Injury",
    :color_code => "#c85179",
    :counted_absent => true,
    :disable_credit => false,
    :credit_rate => 0.80,
    :auto_credit => true
  },

  {
    :name => "Mourning",
    :color_code => "#7d7d7d",
    :counted_absent => true,
    :disable_credit => false,
    :credit_rate => 1.00,
    :auto_credit => true
  },

  {
    :name => "Absent",
    :color_code => "#e60033",
    :counted_absent => true,
    :disable_credit => true,
    :credit_rate => 1.00,
    :auto_credit => false
  }
]

types.each do |type|
  Gaku::AttendanceType.where(type).first_or_create!
end
