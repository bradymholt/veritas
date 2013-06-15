class DefaultController < ApplicationController
 def index
    respond_to do |format|
      format.html { redirect_to :controller => :couples }
    end
  end
end
