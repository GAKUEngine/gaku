# -*- encoding: utf-8 -*-
# Array format ['en scholarship_status', 'ja scholarship_status', 'is_default']
scholarship_statuses = [
  ['Self Paid',                   '自己支払っ',       true ],
  ['Government Scholarship',      '政府奨学金',       false],
  ['School Scholarship',          '学校の奨学金',     false],
  ['Organizational Scholarship',  '組織の奨学金',     false],
  ['Charity Scholarship',         'チャリティー奨学金',  false],
]

scholarship_statuses.each do |status|
  I18n.locale = :en
  scholarship_status = Gaku::ScholarshipStatus.where(:name => status[0], :is_default => status[2]).first_or_create!

  I18n.locale = :ja
  scholarship_status.update_attribute(:name,  status[1])
end

I18n.locale = nil