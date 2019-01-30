statuses = [
  { code: 'applicant', name: 'Applicant', name_ja: '志願', active: false },
  { code: 'admitted',  name: 'Admitted',  name_ja: '入学', active: true },
  { code: 'enrolled',  name: 'Enrolled',  name_ja: '在学', active: true },
  { code: 'transferred_in', name: 'Transfered In', name_ja: '転入', active: true },
  { code: 'transferred_out', name: 'Transfered Out', name_ja: '転出', active: false },
  { code: 'course_transfer_in', name: 'Course Transfer In', name_ja: '編入', active: true },
  { code: 'course_transfer_out', name: 'Course Transfer Out', name_ja:  '編出', active: false },
  { code: 'visiting', name: 'Visiting', name_ja: '留学', active: true },
  { code: 're_admitted', name: 'Re-Admitted', name_ja: '再入学', active: true },
  { code: 'for_credit_exchange', name: 'For-Credit Exchange', name_ja: '単位認定留学', active: true },
  { code: 'non_credit_exchange', name: 'Non-Credit Exchange', name_ja: '休学留学', active: true },
  { code: 'repeat', name: 'Repeat', name_ja: '留年', active: true },
  { code: 'held_back', name: 'Held Back', name_ja: '原級留置', active: true },
  { code: 'inactive', name: 'Inactive', name_ja: '休学', active: false },
  { code: 'graduated', name: 'Graduated', name_ja: '卒業', active: false },
  { code: 're_enrolled', name: 'Re-Enrolled', name_ja: '復学', active: true },
  { code: 'suspended', name: 'Suspended', name_ja: '退学', active: false },
  { code: 'expelled', name: 'Expelled', name_ja: '停学', active: false },
  { code: 'dropped_out', name: 'Dropped Out', name_ja: '自主退学', active: false },
  { code: 'terminal_leave', name: 'Terminal Leave', name_ja: '除籍', active: false },
  { code: 'on_leave', name: 'On Leave', name_ja: '一時自主退学', active: false },
  { code: 'extended_absence', name: 'Extended Absence', name_ja: '長期自主退学', active: false },
  { code: 'deleted', name: 'Deleted', name_ja: '削除', active: false }
]

statuses.each do |status|
  I18n.locale = :en
  es = Gaku::EnrollmentStatus.where(
    code: status[:code],
    name: status[:name],
    active: status[:active],
    immutable: true
  ).first_or_create

  I18n.locale = :ja
  es.update_attribute(:name, status[:name_ja])
end
