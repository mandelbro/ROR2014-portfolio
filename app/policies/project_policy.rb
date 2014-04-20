class ProjectPolicy < ApplicationPolicy

  class Scope < Struct.new(:user, :scope)
    def resolve

      if user && user.editor?
        scope.all
      else
        scope.where(published: true)
      end

    end
  end

  def show?
    record.published? || editor?
  end

  alias_method :comment?, :show?

  def create?
    editor?
  end

  alias_method :update?, :create?

  alias_method :destroy?, :update?

  def publish?
    editor?
  end

  def permitted_attributes
    if user.editor?
      [:company, :body, :technologies, :lead_image, :other_images, :quote, :quote_attr, :published]
    end
  end

  private

    def authenticated?
      !user.nil?
    end

    def editor?
      authenticated? && user.editor?
    end

end
