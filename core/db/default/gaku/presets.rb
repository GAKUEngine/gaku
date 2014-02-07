if Gaku::Preset.count.zero?
  Gaku::Preset.create!(
                        name: 'Default',
                        default: true,
                        active: true,
                        locale: 'en',
                        names_order: '%first %middle %last',
                        pagination: {
                                      default: 25,
                                      students: 25,
                                      teachers: 25,
                                      changes: 25
                                    },
                        person: { gender: true },
                        student: { id_code: '%year-%yearly_serial'},
                        address: { country: 'JP', state: 'Aichi', city: 'Nagoya' },
                        grading: { scheme: '', method: '' },
                        export_formats: { spreadsheets: 'xls', printables: 'pdf', documents: 'xls' },

                        chooser_fields: {
                                          show_code: 1,
                                          show_class_name: 1,
                                          show_admitted: 1,
                                          show_primary_address: 1,
                                          show_primary_contact: 1,
                                          show_personal_information: 1
                                        }
                      )
end