class CommentPolicy < ApplicationPolicy
  class Scope < Struct.new(:user, :scope)
    def resolve

      if user.nil?
        scope.where(approved: true)
      else
        if user.editor?
          scope.all
        else
          scope.where("(user_id = ? OR approved = ?)", user.id, true).order('created_at ASC')
        end
      end

    end
  end

  def create?
    authenticated?
  end

  def update?
    editor?
  end

  def destroy?
    editor? || owner_of?
  end

  def permitted_attributes
    if user.editor?
      [:content, :referrer, :approved]
    else
      [:content, :referrer]
    end
  end

  private

    def authenticated?
      !user.nil?
    end

    def editor?
      authenticated? && user.editor?
    end

    def owner_of?
      authenticated? && record.user == user
    end

end
