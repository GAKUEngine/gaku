Gaku::AttendanceType.create({
  :name => "Present",
  :color_code => "#000000",
  :counted_absent => false,
  :disable_credit => false,
  :credit_rate => 1.00,
  :auto_credit => false
})

Gaku::AttendanceType.create({
  :name => "Present for Credit",
  :color_code => "#000000",
  :counted_absent => false,
  :disable_credit => false,
  :credit_rate => 1.00,
  :auto_credit => true
})

Gaku::AttendanceType.create({
  :name => "Excused",
  :color_code => "#000000",
  :counted_absent => false,
  :disable_credit => false,
  :credit_rate => 1.00,
  :auto_credit => true
})

Gaku::AttendanceType.create({
  :name => "Illness",
  :color_code => "#000000",
  :counted_absent => true,
  :disable_credit => false,
  :credit_rate => 0.80,
  :auto_credit => true
})

Gaku::AttendanceType.create({
  :name => "Injury",
  :color_code => "#000000",
  :counted_absent => true,
  :disable_credit => false,
  :credit_rate => 0.80,
  :auto_credit => true
})

Gaku::AttendanceType.create({
  :name => "Mourning",
  :color_code => "#000000",
  :counted_absent => true,
  :disable_credit => false,
  :credit_rate => 1.00,
  :auto_credit => true
})

Gaku::AttendanceType.create({
  :name => "absent",
  :color_code => "#000000",
  :counted_absent => true,
  :disable_credit => true,
  :credit_rate => 1.00,
  :auto_credit => false
})
