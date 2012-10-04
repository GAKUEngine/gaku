class AttachmentsController < ApplicationController
	
	inherit_resources


	def create
		@attachable = find_attachable 
		@attachment = @attachable.attachments.build(params[:attachment])
		respond_to do |format|
			if @attachment.save
				format.html { redirect_to :back, :notice => 'Asset upload was successful!' }
			else
				format.html { redirect_to :back, :error => 'Error when upload asset'}
			end
		end
	end

	def destroy 
		super do |format|
			format.js { render :nothing => true }
		end
	end

	def soft_delete
		@attachment = Attachment.find(params[:id])
		@attachment.update_attribute(:is_deleted, true)
		render :nothing => true
	end

	def download
		@attachment = Attachment.find(params[:id])
		send_file @attachment.asset.path 
	end

	def recovery
		@attachment = Attachment.unscoped.find(params[:id])
		@attachment.update_attribute(:is_deleted, false)
		flash.now[:notice] = t('attachments.attachment_recovered')
		respond_to do |format|
			format.js { render 'admin/disposals/recover_attachment'}
		end
	end

	private

	def find_attachable
		# extract all params with _id
		resource_params = params.select{|p| p =~ /(.+)_id$/ }
		# get last param with _id to find attachable(need when there are more than one _id)
		resource_params.each_with_index do |(k,v), i|
   	  if i == resource_params.length - 1
   			return $1.classify.constantize.find(v) if k =~ /(.+)_id$/
    	end
  	end
  	nil
	end

end