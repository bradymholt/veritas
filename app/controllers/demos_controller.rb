class DemosController < ApplicationController
  # GET /demos
  # GET /demos.json
  def index
    @demos = Demo.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @demos }
    end
  end

  # GET /demos/1
  # GET /demos/1.json
  def show
    @demo = Demo.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @demo }
    end
  end

  # GET /demos/new
  # GET /demos/new.json
  def new
    @demo = Demo.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @demo }
    end
  end

  # GET /demos/1/edit
  def edit
    @demo = Demo.find(params[:id])
  end

  # POST /demos
  # POST /demos.json
  def create
    @demo = Demo.new(params[:demo])

    respond_to do |format|
      if @demo.save
        format.html { redirect_to @demo, notice: 'Demo was successfully created.' }
        format.json { render json: @demo, status: :created, location: @demo }
      else
        format.html { render action: "new" }
        format.json { render json: @demo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /demos/1
  # PUT /demos/1.json
  def update
    @demo = Demo.find(params[:id])

    respond_to do |format|
      if @demo.update_attributes(params[:demo])
        format.html { redirect_to @demo, notice: 'Demo was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @demo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /demos/1
  # DELETE /demos/1.json
  def destroy
    @demo = Demo.find(params[:id])
    @demo.destroy

    respond_to do |format|
      format.html { redirect_to demos_url }
      format.json { head :no_content }
    end
  end
end
