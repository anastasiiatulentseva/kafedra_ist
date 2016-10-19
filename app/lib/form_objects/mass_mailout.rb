module FormObjects
  class MassMailout
    include ::ActiveModel::Model

    attr_accessor :subject, :text, :users, :role, :specialty_ids, :course_years, :groups, :attachment

    validates :users, presence: { message: :user_list_blank }
    validates :subject, :text, presence: true

  end
end
