class Instructor::CoursesController < ApplicationController
  before_action :authenticate_user!
  before_action :require_authorized_for_current_user, only: [:show]

  def new
    @course = Course.new
  end

  def create
    byebug
    @course = current_user.courses.create(course_params)
    if @course.valid?
      redirect_to instructor_course_path(@course)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @section = Section.new
    @lesson = Lesson.new
  end

  private

  def require_authorized_for_current_user
    if current_course.user != current_user
      render plain: 'Unauthorized', status: :unauthorized
    end
  end

  helper_method :current_course
  def current_course
    @current_course ||= Course.find(params[:id])
  end

  def course_params
    params.require(:course).permit(:title, :description, :cost, :image)
  end
end
