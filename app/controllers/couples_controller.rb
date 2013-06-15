class CouplesController < ApplicationController
  # GET /couples
  # GET /couples.json
  def index
    @couples = Couple.all

    respond_to do |format|
      format.html # index.html.erb
      format.js
      format.json { render json: @couples }
    end
  end

  # GET /couples/1
  # GET /couples/1.json
  def show
    @couple = Couple.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @couple }
    end
  end

  # GET /couples/new
  # GET /couples/new.json
  def new
    @couple = Couple.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @couple }
    end
  end

  # GET /couples/1/edit
  def edit
    @couple = Couple.find(params[:id])
  end

  # POST /couples
  # POST /couples.json
  def create
    @couple = Couple.new(params[:couple])

    respond_to do |format|
      if @couple.save
        format.html { redirect_to couples_url, notice: 'Couple was successfully created.' }
        format.json { render json: @couple, status: :created, location: @couple }
      else
        format.html { render action: "new" }
        format.json { render json: @couple.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /couples/1
  # PUT /couples/1.json
  def update
    @couple = Couple.find(params[:id])

    respond_to do |format|
      if @couple.update_attributes(params[:couple])
        format.html { redirect_to couples_url, notice: 'Couple was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @couple.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /couples/1
  # DELETE /couples/1.json
  def destroy
    @couple = Couple.find(params[:id])
    puts 
    @couple.is_active = false
    if !@couple.save
     @couple.errors.full_messages.each do |msg|
      puts msg
    end
  end

    respond_to do |format|
      format.html { redirect_to couples_url, notice: 'Couple was successfully marked inactive.' }
      format.json { head :no_content }
    end
  end
end
