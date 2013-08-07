class AttendancesController < ApplicationController
  skip_before_filter :require_login, :only => [:print]
  skip_before_filter :require_admin, :only => [:print]

  # GET /attendances
  # GET /attendances.json
  def index
    @dates = []
    @last_sunday_date = last_sunday_date
    @last_sunday_date_description = last_sunday_date.strftime('%m/%d/%Y')
    current_sunday_description = 'Last Sunday - '
    last_sunday_descritpion = ''

    if DateTime.now.wday == 0
      current_sunday_description = 'Today - '
      last_sunday_descritpion = 'Last Sunday - '
    end

    @dates << { :date => last_sunday_date, :description => current_sunday_description + @last_sunday_date_description  }
    @dates << { :date => last_sunday_date - 1.week, :description => last_sunday_descritpion + ( last_sunday_date - 1.week).strftime('%m/%d/%Y')  }
    
    for i in 2..3
      date = last_sunday_date - i.week
      @dates <<  { :date => date, :description => date.strftime('%m/%d/%Y') }
    end

    @members = Contact.where(:is_member => true, :is_active => true)
    @visitors = Contact.where(:is_member => false, :is_active => true)

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  def print
     @members = Contact.where(:is_member => true, :is_active => true)
     @visitors = Contact.where(:is_member => false, :is_active => true)
     render layout: "print"
  end

  # GET /attendances/1
  # GET /attendances/1.json
  def show
    date = params[:date]
    if date == 'last'
      date = last_sunday_date
    end
    
    @attendance = Attendance.where(:date => date)

    respond_to do |format|
      format.json { render json: @attendance }
      format.mobile { render json: @attendance }
    end
  end

  def update
    date = params[:date]

    Attendance.mark_attendance(params[:contact_id], date, (params[:present] == true))
    respond_to do |format|
      format.json { head :no_content }
      format.mobile { head :no_content }
    end
  end

  def last_sunday_date
    (DateTime.now - DateTime.now.wday).to_date
  end
end
