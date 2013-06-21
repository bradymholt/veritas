class DefaultController < ApplicationController
 skip_before_filter :require_login, :unless => :mobile_device?
 skip_before_filter :require_admin
 
 def index
    respond_to do |format|
      format.html { render :layout => false }
      format.mobile
    end
  end
end
