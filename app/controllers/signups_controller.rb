class SignupsController < ApplicationController
  skip_before_filter :require_admin, :only => [:signup, :update]

  def index
    @signups = Signup.all
    Signup.fetch_summaries(@signups)
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @signups }
    end
  end

  def show
    @signup = Signup.find(params[:id])
    @contacts = Contact.where(:is_member => true)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @signup }
    end
  end

  def new
    @signup = Signup.new
    @signup.set_new_default_values
    @signup.signup_slots.build #new template
    @contacts = Contact.all
    @facebook_post_enabled = !Setting.cached.facebook_access_token.blank? && !Setting.cached.facebook_group_id.blank?
  end

  def edit
    @signup = Signup.find(params[:id])
    @signup.signup_slots.build #new template
    @contacts = Contact.where(:is_member => true)
    @facebook_post_enabled = !Setting.cached.facebook_access_token.blank? && !Setting.cached.facebook_group_id.blank?
  end

  def signup
    @signup = Signup.find(params[:id])
    Signup.fetch_summaries([@signup])
    @contacts = Contact.where(:is_member => true)
    respond_to do |format|
      format.html  { render :layout => false }
    end
  end

  def create
    @signup = Signup.new(params[:signup])
  
    respond_to do |format|
      if @signup.save
        format.html { redirect_to signups_path, notice: 'Signup was successfully created.' }
        format.json { render json: @signup, status: :created, location: @signup }
      else
        @contacts = Contact.where(:is_member => true)
        @signup.signup_slots.build #new template

        format.html { render action: "new" }
        format.json { render json: @signup.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @signup = Signup.find(params[:id])

    respond_to do |format|
      if @signup.update_attributes(params[:signup])
        format.html { redirect_to params[:redirect_to] || signups_path, notice: 'Signup was successfully updated.' }
        format.json { head :no_content }
      else
        @contacts = Contact.where(:is_member => true)
        @signup.signup_slots.build #new template
      
        format.html { render action: "edit" }
        format.json { render json: @signup.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @signup = Signup.find(params[:id])
    @signup.destroy

    respond_to do |format|
      format.html { redirect_to signups_url, notice: 'Signup was successfully deleted.' }
      format.json { head :no_content }
    end
  end
end
