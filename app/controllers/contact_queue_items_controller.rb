class ContactQueueItemsController < ApplicationController
  def index
    @pending = ContactQueueItem.where(:is_completed => false).joins(:family).order('created_at DESC')
    @completed = ContactQueueItem.where(:is_completed => true).joins(:family).order('completed_date DESC').limit(20)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @contact_queue_items }
    end
  end

  # GET /contact_queue_items/1/edit
  def edit
    @contact_queue_item = ContactQueueItem.find(params[:id])
    @contact_queue_item.completed_by = cookies[:name]
  end

  def update
    @contact_queue_item = ContactQueueItem.find(params[:id])
    @contact_queue_item.is_completed = true
    @contact_queue_item.completed_date = DateTime.now
 
    respond_to do |format|
      if @contact_queue_item.update_attributes(params[:contact_queue_item])
        cookies.permanent[:name] = @contact_queue_item.completed_by 
        format.html { redirect_to contact_queue_items_url, notice: 'Contact queue item was successfully completed.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @contact_queue_item.errors, status: :unprocessable_entity }
      end
    end
  end
end
