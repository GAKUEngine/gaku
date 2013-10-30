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
                        address: { country: 'JP', state: 'Aichi', city: 'Nagoya' },
                        grading: { scheme: '', method: '' },
                        export_formats: { spreadsheets: 'xls', printables: 'pdf', documents: 'xls' },

                        chooser_fields: {
                                          name: 1,
                                          surname: 1,
                                          birth_date: 1,
                                          sex: 1,
                                          class_name: 1,
                                          seat_number: 1,
                                          admitted_on: 1,
                                          primary_address: 1,
                                          primary_contact: 1,
                                          assignments: 1
                                        }
                      )
end