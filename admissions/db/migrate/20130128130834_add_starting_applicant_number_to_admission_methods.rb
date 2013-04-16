class AddStartingApplicantNumberToAdmissionMethods < ActiveRecord::Migration
  def change
    add_column :gaku_admission_methods, :starting_applicant_number, :integer, :default => 1
  end
end
