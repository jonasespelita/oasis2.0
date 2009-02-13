class StudentsController < ApplicationController
  # Student Controller handles requests for Student model via url
  # e.g http://localhost:3000/students/1
  #
  # to test it out you need to configure the database muna
  # dont forget to migrate! =P
  #
  # restful design maps HTTP verbs to methods; in our case, just the show method via the GET HTTP verb
  # this is mapped through the routes.rb file
  # i didnt include na the other HTTP verbs because we're just reading data hehe


  # http://localhost:3000/students/
  def index
    @students = Student.find(:all)
    render :xml => @students # use rail's automatic xml parser to convert object to xml =P
  end


  # http://localhost:3000/students/1
  def show
    @student = Student.find_by_idno(params[:id])
    render :xml => @student
  end

end
