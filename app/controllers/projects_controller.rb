class ProjectsController < ApplicationController
  before_filter :set_project, :only => [:show, :edit, :update, :destroy]
  before_filter :set_projects, :only => [:index, :update, :create, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  after_action :verify_authorized, except: :index
  after_action :verify_policy_scoped, only: :index

  def index
  end

  def show
    authorize @project
    @comment = Comment.new
    @comments = policy_scope(@project.comments)
  end

  def new
    @project = Project.new
    authorize @project, :create?
  end

  def create
    @project = Project.new(project_params)
    authorize @project
    current_user.projects << @project

    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: 'Project was successfully created.' }
        format.json { render action: 'show', status: :created, location: @project }
        format.js
      else
        format.html { render action: 'new' }
        format.json { render json: @project.errors, status: :unprocessable_entity }
        format.js { render text: @project.errors.full_messages.join, status: :unprocessable_entity }
      end
    end
  end

  def edit
    authorize @project, :update?
  end

  def update
    authorize @project
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to @project, notice: "Project \"#{@project.company}\" was successfully updated." }
        format.json { head :no_content }
        format.js
      else
        format.html { render action: 'edit' }
        format.json { render json: @project.errors, status: :unprocessable_entity }
        format.js { render text: @project.errors.full_messages.join, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    authorize @project
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url, notice: 'Project was successfully deleted.' }
      format.json { head :no_content }
      format.js
    end
  end

  private

  def set_project
    @project = Project.find(params[:id])
  end

  def set_projects
    @projects = policy_scope(Project)
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def project_params
    params.require(:project).permit(*policy(@project || Project).permitted_attributes)
  end

end
