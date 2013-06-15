class SettingsController < ApplicationController
  def index
     @settings = Setting.cached
     render :action => "edit"
  end

  def update
    @settings = Setting.cached

    respond_to do |format|
      if @settings.update_attributes(params[:setting])
        Rails.cache.clear("settings")
        format.html { redirect_to settings_path, notice: 'Settings were successfully saved.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @settings.errors, status: :unprocessable_entity }
      end
    end
  end
end
