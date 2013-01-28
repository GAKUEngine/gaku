class AddApplicantNumberToAdmissions < ActiveRecord::Migration
  def change
    add_column :gaku_admissions, :applicant_number, :integer
  end
end
