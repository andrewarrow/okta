module Okta
  class User
    attr_accessor :id, :status, :email, :firstName, :lastName

    def self.find(id)
      user = Okta.get("/users/#{id}")
      new(user)
    end

    def initialize(attrs = {})

    end
  end
end
