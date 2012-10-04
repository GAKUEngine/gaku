class Attachment < ActiveRecord::Base
	attr_accessible :name, :description

	belongs_to :attachable, :polymorphic => true

end