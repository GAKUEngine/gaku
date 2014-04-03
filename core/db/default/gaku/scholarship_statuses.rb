# -*- encoding: utf-8 -*-

scholarship_statuses = [
  { name: 'Self Paid',                  name_ja: '自己支払い',       default: true },
  { name: 'Government Scholarship',     name_ja: '政府奨学金',       default: false },
  { name: 'School Scholarship',         name_ja: '学校の奨学金',     default: false },
  { name: 'Organizational Scholarship', name_ja: '組織の奨学金',     default: false },
  { name: 'Charity Scholarship',        name_ja: 'チャリティー奨学金', default: false }
]

scholarship_statuses.each do |status|
  I18n.locale = :en
  scholarship_status = Gaku::ScholarshipStatus.where(
                                                        name: status[:name],
                                                        default: status[:default]
                                                      ).first_or_create!

  I18n.locale = :ja
  scholarship_status.update_attribute(:name,  status[:name_ja])
end

I18n.locale = :en
