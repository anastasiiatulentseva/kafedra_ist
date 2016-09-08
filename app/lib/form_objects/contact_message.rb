module FormObjects
  class ContactMessage
    include ::ActiveModel::Model

    attr_accessor :subject, :text, :recipient_id

    validates :subject, :text, :recipient_id, presence: true

  end
end
