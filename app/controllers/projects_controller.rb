class ProjectsController < ApplicationController
   before_filter :get_project, :only => [:show, :edit, :update, :destroy]

  def index
    @projects = Project.all
  end

  def show
    @comment = @project.comments.new
    @comments = policy_scope(@project.comments)
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      flash[:notice] = "Project was successfully created."
      redirect_to @project
    else
      # we'll get to this in a bit
    end
  end

  def edit
  end

  def update
    @project.update_attributes(project_params)
    if @project.save
      flash[:notice] = "Project \"#{@project.company}\" was successfully updated."
      redirect_to @project
    else
      # we'll get to this in a bit
    end
  end

  def destroy
    if @project.destroy
      flash[:notice] = "Project was successfully deleted."
      redirect_to projects_path
    else
      # we'll get to this in a bit
    end
  end

  private

  def get_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:company, :body, :technologies, :lead_image, :other_images, :quote, :quote_attr)
  end

end
