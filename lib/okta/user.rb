module Okta
  class User
    attr :status, :raw
    attr_accessor :email, :firstName, :lastName

    # 
    # User id
    # 
    # @return [String] user id    
    def id
      @id ||= email
    end

    # 
    # Get all users
    # @param params [Hash] optional parameters
    # 
    # @return [Array<User>] all users
    def self.all
      Okta.get("/users").map do |user|
        new.parse(user)
      end
    end

    # 
    # Find user by id
    # @param id [String] user id
    # 
    # @return [User] user model
    def self.find(id)
      user = Okta.get("/users/#{id}")
      new.parse(user)
    end

    # 
    # Initialize user
    # @param [Hash] attrs user attributes
    # @option attrs [String] :email user email/login
    # @option attrs [String] :firstName user first name
    # @option attrs [String] :lastName user last name
    # 
    # @return [User] user object
    def initialize(attrs = {})
      attrs.each do |key, value|
        send("#{key}=", value)
      end
    end

    # 
    # Parse JSON attributes
    # @param attrs [Hash] parsed JSON attributes 
    # 
    # @return [User] user object
    def parse(attrs)
      @id = attrs['id']
      @status = attrs['status']
      @email = attrs['profile']['email']
      @firstName = attrs['profile']['firstName']
      @lastName = attrs['profile']['lastName']
      @raw = attrs
      self
    end

    # 
    # Get member groups
    # 
    # @return [Array<Group>] member groups
    def groups()
      Okta.get("/users/#{id}/groups").map do |group|
        Group.new.parse(group)
      end
    end
  end
end
