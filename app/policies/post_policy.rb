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
    record.published? || (editor? || owner_of?)
  end

  def create?
    author?
  end

  def update?
    editor? || owner_of?
  end

  alias_method :destroy?, :update?

  def publish?
    editor?
  end

  def comment?
    authenticated?
  end

  def permitted_attributes
    if user.editor?
      [:title, :body, :published]
    else
      [:title, :body]
    end
  end

  private

    def authenticated?
      !user.nil?
    end

    def editor?
      authenticated? && user.editor?
    end

    def author?
      authenticated? && user.author?
    end

    def owner_of?
      authenticated? && record.author == user
    end

end
