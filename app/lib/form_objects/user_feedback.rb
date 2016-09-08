module FormObjects
  class UserFeedback
    include ::ActiveModel::Model

    attr_accessor :text, :user_email

    validates :text, :user_email, presence: true

  end
end
