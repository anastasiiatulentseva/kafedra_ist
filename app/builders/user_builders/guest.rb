# app/builders/user_builders/guest.rb
module UserBuilders
  class Guest
    def build
      User.new(
        name:  "Guest",
        email: generate_guest_email,
        guest: true,
      )
    end

    private

    def generate_guest_email
      "guest_#{Time.now.to_i}#{rand(100)}@example.com"
    end
  end
end
