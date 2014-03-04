class PostPolicy < ApplicationPolicy

  class Scope < Struct.new(:user, :scope)
    def resolve

      if user && user.editor?
        scope.all
      elsif user && user.author?
        scope.where(author: user)
      else
        scope.where(published: true)
      end

    end
  end

  def show?
    record.published? || (user.editor? || owner_of?)
  end

  def create?
    authenticated?
  end

  def update?
    authenticated? && (user.editor? || owner_of?)
  end

  def destroy?
    authenticated? && (user.editor? || owner_of?)
  end

  def publish?
    authenticated? && user.editor?
  end

  def owner_of?
    record.author == user
  end

  def authenticated?
    !user.nil?
  end

  def permitted_attributes
    if user.editor?
      [:title, :body, :published]
    else
      [:title, :body]
    end
  end

end
