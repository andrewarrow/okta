module Okta
  class Group
    attr :id, :type, :raw
    attr_accessor :name, :description, :groupType

    # 
    # Get all groups
    # @param params [Hash] optional parameters
    # 
    # @return [Array<Group>] group models
    def self.all(params = {})
      Okta.get("/groups", params).map do |group|
        new.parse(group)
      end
    end

    # 
    # Find group by id
    # @param id [String] group id
    # 
    # @return [Group] group model
    def self.find(id)
      group = Okta.get("/groups/#{id}")
      new.parse(group)
    end

    # 
    # Initialize group
    # @param [Hash] attrs group attributes
    # @option attrs [String] :name group name
    # @option attrs [String] :description group description
    # @option attrs [String] :groupType group type
    # 
    # @return [Group] group object
    def initialize(attrs = {})
      attrs.each do |key, value|
        send("#{key}=", value)
      end
    end

    # 
    # Parse JSON attributes
    # @param attrs [Hash] parsed JSON attributes 
    # 
    # @return [Group] group object
    def parse(attrs)
      @id = attrs['id']
      @type = attrs['type']
      @name = attrs['profile']['name']
      @description = attrs['profile']['description']
      @groupType = attrs['profile']['groupType']
      @raw = attrs
      self
    end
  end
end
