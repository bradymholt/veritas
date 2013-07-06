class ContactsController < ApplicationController
  skip_before_filter :require_admin, :only => [:members,:edit,:update,:show]
  
    def index
      @contacts = Contact.all

      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @contacts }
        format.csv { send_data Contact.to_csv(@contacts), :filename => 'contacts.csv'} 
        format.xls { send_data Contact.to_csv(@contacts, col_sep: "\t"), :filename => 'contacts.xls' }
      end
    end

    def members
     @contacts = Contact.where(:is_member => true, :is_active => true)
     respond_to do |format|
          format.html # index.html.erb
          format.mobile
        end
      end

    def show
        @contact = Contact.find(params[:id])

        respond_to do |format|
        format.html # show.html.erb
        format.mobile { render formats => [:mobile] }
        format.json { render json: @contact }
      end
    end

    def events
      contacts = Contact.where(:is_member => true, :is_active => true) 
      @upcoming_dates = Contact.upcoming_dates(contacts, DateTime.now + 3.months)

      respond_to do |format|
        format.mobile
      end
    end

    def new
      @contact = Contact.new

      respond_to do |format|
        format.html # new.html.erb
        format.json { render json: @contact }
      end
    end

    def edit
      @contact = Contact.find(params[:id])

      respond_to do |format|
        format.html
        format.mobile
      end
    end

    def create
      @contact = Contact.new(params[:contact])

      if @contact.save
       redirect_to contacts_url, notice: 'Contact was successfully created.'
     else
      render action: "new"
    end
  end

  def update
    @contact = Contact.find(params[:id])

    if @contact.update_attributes(params[:contact])
      respond_to do |format|
        format.html { 
          flash[:notice] = 'Contact was successfully updated.' 
          if request.xhr? 
            head :no_content
          else
            redirect_to contacts_url
          end
        }
        format.mobile { redirect_to members_url }
      end
      
    else
      render action: "edit", status: :unprocessable_entity
    end
  end

  def destroy
    @contact = Contact.unscoped.find(params[:id])
    puts 
    @contact.is_active = false
    redirect_to contacts_url, notice: 'Contact was successfully marked inactive.'
  end
end
