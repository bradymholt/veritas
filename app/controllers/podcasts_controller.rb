class PodcastsController < ApplicationController
  # GET /podcasts
  # GET /podcasts.json
  def index
    @podcasts = Podcast.order('date DESC').limit(50)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @podcasts }
      format.rss { render :layout => false }
    end
  end

  # GET /podcasts/1
  # GET /podcasts/1.json
  def show
    @podcast = Podcast.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @podcast }
    end
  end

  # GET /podcasts/new
  # GET /podcasts/new.json
  def new
    @podcast = Podcast.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @podcast }
    end
  end

  # GET /podcasts/1/edit
  def edit
    @podcast = Podcast.find(params[:id])
  end

  # POST /podcasts
  # POST /podcasts.json
  def create
    @podcast = Podcast.new(params[:podcast])

    respond_to do |format|
      if @podcast.save
        format.html { redirect_to :podcasts, notice: 'Podcast was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  # PUT /podcasts/1
  # PUT /podcasts/1.json
  def update
    @podcast = Podcast.find(params[:id])

    respond_to do |format|
      if @podcast.update_attributes(params[:podcast])
        format.html { redirect_to podcasts_path, notice: 'Podcast was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @podcast.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /podcasts/1
  # DELETE /podcasts/1.json
  def destroy
    @podcast = Podcast.find(params[:id])
    @podcast.destroy

    respond_to do |format|
      format.html { redirect_to podcasts_url }
      format.json { head :no_content }
    end
  end
end
