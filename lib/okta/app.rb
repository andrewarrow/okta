module Okta
  class App
    def self.find(id)
      Okta.get("/apps/#{id}")
    end
  end
end
