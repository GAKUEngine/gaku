# == Schema Information
#
# Table name: attachments
#
#  id                 :integer          not null, primary key
#  name               :string(255)
#  description        :text
#  is_deleted         :boolean          default(FALSE)
#  attachable_id      :integer
#  attachable_type    :string(255)
#  asset_file_name    :string(255)
#  asset_content_type :string(255)
#  asset_file_size    :integer
#  asset_updated_at   :datetime
#

class Attachment < ActiveRecord::Base
	
	attr_accessible :name, :description, :asset

	belongs_to :attachable, :polymorphic => true

	has_attached_file :asset

	validates :name, :presence => true

	default_scope :conditions => { :is_deleted => false }

end
