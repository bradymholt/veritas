class MobilesController < ApplicationController
  # GET /mobiles
  # GET /mobiles.json
  def index
    respond_to do |format|
      format.mobile 
    end
  end
end
