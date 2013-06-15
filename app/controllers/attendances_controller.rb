class AttendancesController < ApplicationController
  # GET /attendances
  # GET /attendances.json
  def index
    @dates = []
    current_sunday = (DateTime.now - DateTime.now.wday).to_date
    current_sunday_description = 'Last Sunday - '
    last_sunday_descritpion = ''
    if DateTime.now.wday == 0
      current_sunday_description = 'Today - '
      last_sunday_descritpion = 'Last Sunday - '
    end

    @dates << { :date => current_sunday, :description => current_sunday_description + current_sunday.strftime('%m/%d/%Y')  }
    @dates << { :date => current_sunday - 1.week, :description => last_sunday_descritpion + ( current_sunday - 1.week).strftime('%m/%d/%Y')  }
    
    for i in 2..3
      date = current_sunday - i.week
      @dates <<  { :date => date, :description => date.strftime('%m/%d/%Y') }
    end

     @members = Couple.where(:is_active => true, :is_member => true)
     @visitors = Couple.where(:is_active => true, :is_member => false)

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /attendances/1
  # GET /attendances/1.json
  def show
    @attendance = Attendance.where(:date =>  params[:date])

    respond_to do |format|
      format.json { render json: @attendance }
    end
  end

  def update
    Attendance.mark_attendance(params[:couple_id], params[:date], (params[:husband_present] == true), (params[:wife_present] == true))
    respond_to do |format|
        format.json { head :no_content }
    end
  end
end
