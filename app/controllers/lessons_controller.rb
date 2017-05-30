class LessonsController < ApplicationController
before_action :authenticate_user!
before_action :require_authorized_for_current_user
  
  def show
  end

  private

  helper_method :current_lesson
  def current_lesson
    @current_lesson ||= Lesson.find(params[:id])
  end

  def require_authorized_for_current_user
    current_course = current_lesson.section.course
    if !current_user.enrolled_in?(current_course)
      redirect_to course_path(current_course), alert: 'Sorry, You Are Not Enrolled In This Course.'
    end    
  end
end
