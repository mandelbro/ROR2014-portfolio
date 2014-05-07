module ProjectsHelper

  def create?
    policy(Project.new).create?
  end

  def publish? project
    policy(project).publish?
  end

  def update? project
    policy(project).update?
  end

  def destroy? project
    policy(project).update?
  end

  def publish? project
    policy(project).publish?
  end

  def comment? project
    policy(project).comment?
  end

end
