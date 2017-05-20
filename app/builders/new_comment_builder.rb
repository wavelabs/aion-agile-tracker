class NewCommentBuilder
  def initialize(resource = nil)
    @model = resource || Comment.new
  end

  def set_user(user)
    model.user = user
    self
  end

  def set_commentable(commentable)
    model.commentable = commentable
    self
  end

  def assign_attributes(attrs)
    model.assign_attributes(attrs)
    self
  end

  def build
    model
  end

  private

  attr_reader :model

  def role
    Role.admin
  end
end
