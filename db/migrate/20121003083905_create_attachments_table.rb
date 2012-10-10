class CreateAttachmentsTable < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
    	t.string 		 :name
  		t.text 	 		 :description
			t.boolean		 :is_deleted, :default => false    	
    	t.references :attachable, :polymorphic => true
    end

    add_attachment :attachments, :asset
  end
end
