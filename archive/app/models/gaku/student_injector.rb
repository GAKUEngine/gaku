Gaku::Student.class_eval do

  include Trashable

  has_paper_trail class_name: 'Gaku::Versioning::StudentVersion',
                  on: [:update, :destroy],
                  only: [
                    :name, :surname, :middle_name,
                    :foreign_id_code,
                    :scholarship_status_id,
                    :commute_method_type_id, :enrollment_status_code,
                    :deleted
                      ]

end
