class AddSeatNumberToEnrollments < ActiveRecord::Migration[4.2]
  def change
    add_column :gaku_enrollments, :seat_number, :integer
  end
end
