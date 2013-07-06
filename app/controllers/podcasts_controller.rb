class PodcastsController < ApplicationController
 skip_before_filter :require_login, :only => [:index]
 skip_before_filter :require_admin, :only => [:index]
 skip_before_filter :require_login, :only => [:feed]
 skip_before_filter :require_admin, :only => [:feed]
 
  # GET /podcasts
  # GET /podcasts.json
  def index
    @podcasts = Podcast.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @podcasts }
      format.rss { render :layout => false }
    end
  end

  def feed
     @podcasts = Podcast.all
    respond_to do |format|
      format.any
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
    if params[:id] == 'last'
      @podcast = Podcast.unscoped.last
      redirect_to edit_podcast_url(@podcast)
    else
      @podcast = Podcast.find(params[:id])
    end
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
        format.mobile { redirect_to podcasts_path }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.mobile { render action: "edit" }
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
      format.html { redirect_to podcasts_url, notice: 'Podcast was successfully deleted.' }
      format.json { head :no_content }
    end
  end
end
