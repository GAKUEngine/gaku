FactoryBot.define do
  factory :preset, class: Gaku::Preset do
    name 'Default'
    names_order '%first %middle %last'
    active true
    default true
    pagination { {} }
    person { {} }
    student { { increment_foreign_id_code: 0 } }
    address { {} }
    export_formats { {} }
    chooser_fields { {} }
    grading { {} }
  end
end
