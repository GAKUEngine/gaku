class CreateAttachmentsTable < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
    	t.string 		 :name
  		t.text 	 		 :description
    	
    	t.references :attachable, :polymorphic => true
    end

    add_attachment :attachments, :asset
  end
end
