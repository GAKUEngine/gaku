class AddSeatNumberToEnrollments < ActiveRecord::Migration
  def change
    add_column :gaku_enrollments, :seat_number, :integer
  end
end
