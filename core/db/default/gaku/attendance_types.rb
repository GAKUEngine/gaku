types = [
  {
    name: 'Present',
    name_ja: 'Japanese Present',
    color_code: '#006e54',
    counted_absent: false,
    disable_credit: false,
    credit_rate: 1.00,
    auto_credit: false
  },

  {
    name: 'Present for Credit',
    name_ja: 'Japanese Present for Credit',
    color_code: '#00a497',
    counted_absent: false,
    disable_credit: false,
    credit_rate: 1.00,
    auto_credit: true
  },

  {
    name: 'Excused',
    name_ja: 'Japanese Excused',
    color_code: '#2c4f54',
    counted_absent: false,
    disable_credit: false,
    credit_rate: 1.00,
    auto_credit: true
  },

  {
    name: 'Illness',
    name_ja: 'Japanese Illness',
    color_code: '#4d4398',
    counted_absent: true,
    disable_credit: false,
    credit_rate: 0.80,
    auto_credit: true
  },

  {
    name: 'Injury',
    name: 'Japanese Injury',
    color_code: '#c85179',
    counted_absent: true,
    disable_credit: false,
    credit_rate: 0.80,
    auto_credit: true
  },

  {
    name: 'Mourning',
    name_ja: 'Japanese Mourning',
    color_code: '#7d7d7d',
    counted_absent: true,
    disable_credit: false,
    credit_rate: 1.00,
    auto_credit: true
  },

  {
    name: 'Absent',
    name_ja: 'Japanese Absent',
    color_code: '#e60033',
    counted_absent: true,
    disable_credit: true,
    credit_rate: 1.00,
    auto_credit: false
  }
]


types.each do |type|
  I18n.locale = :en
  attendance_type = Gaku::AttendanceType.create!(
                                                  name:           type[:name],
                                                  color_code:     type[:color_code],
                                                  counted_absent: type[:counted_absent],
                                                  disable_credit: type[:disable_credit],
                                                  credit_rate:    type[:credit_rate],
                                                  auto_credit:    type[:auto_credit]
                                                )

  I18n.locale = :ja
  attendance_type.update_attributes(name: type[:name_ja])
end
