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
      session[:contact_edit_referrer] = request.referrer || contacts_url

      respond_to do |format|
        format.html # new.html.erb
        format.json { render json: @contact }
      end
    end

    def edit
      @contact = Contact.find(params[:id])
      session[:contact_edit_referrer] = request.referrer || contacts_url

      respond_to do |format|
        format.html
        format.mobile
      end
    end

    def create
      @contact = Contact.new(params[:contact])

      if @contact.save
       handle_emails(@contact, params[:commit])
       email_notice = params[:commit].downcase != "save" ? ' and email sent' : ''
       notice_message = "Contact was successfully created#{email_notice}."
  
       redirect_to session[:contact_edit_referrer], notice: notice_message
     else
      render action: "new"
    end
  end

  def update
    @contact = Contact.find(params[:id])

    if @contact.update_attributes(params[:contact])
      handle_emails(@contact, params[:commit])
      email_notice = params[:commit].downcase != "save" ? ' and email sent' : ''
      notice_message = "Contact was successfully updated#{email_notice}."
    
      respond_to do |format|
        format.html { 
          flash[:notice] = notice_message
          if request.xhr? 
            head :no_content
          else
            redirect_to session[:contact_edit_referrer]
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

  def handle_emails(contact, commit_value)
    Thread.new do
      begin
       if commit_value == "save-send-visitor-email"
         UserMailer.visitor_email(contact).deliver
       elsif commit_value == "save-send-new-member-email"
         UserMailer.new_member_email(contact).deliver
       end 
      ensure
        ActiveRecord::Base.connection_pool.release_connection
      end
    end
  end
end