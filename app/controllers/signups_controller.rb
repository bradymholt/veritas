class SignupsController < ApplicationController
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
    @families = Family.all

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @signup }
    end
  end

  def new
    @signup = Signup.new
    @signup.signup_slots.build #new template
    @families = Family.all
  end

  def edit
    @signup = Signup.find(params[:id])
    @signup.signup_slots.build #new template
    @families = Family.all
  end

  def signup
    @signup = Signup.find(params[:id])
    @families = Family.all
    respond_to do |format|
      format.html  { render :layout => false }
    end
  end

  def create
    @signup = Signup.new(params[:signup])
    puts @signup.to_yaml
  
    respond_to do |format|
      if @signup.save
        format.html { redirect_to signups_path, notice: 'Signup was successfully created.' }
        format.json { render json: @signup, status: :created, location: @signup }
      else
        @families = Family.all
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
        format.html { redirect_to signups_path, notice: 'Signup was successfully updated.' }
        format.json { head :no_content }
      else
        @families = Family.all
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
