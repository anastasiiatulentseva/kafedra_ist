module FormObjects
  class MassMailout
    include ::ActiveModel::Model

    attr_accessor :subject, :text, :users, :role, :specialty_ids, :course_years, :groups, :attachment

    validates :users, presence: { message: "list is empty, select other group of users" }
    validates :subject, :text, presence: true

  end
end
