class CreateGakuAttachmentsTable < ActiveRecord::Migration
  def change
    create_table :gaku_attachments do |t|
    	t.string 		 :name
  		t.text 	 		 :description
			t.boolean		 :is_deleted, :default => false
      
    	t.references :attachable, :polymorphic => true
    end

    add_attachment :gaku_attachments, :asset
  end
end
