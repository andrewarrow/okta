module Okta
  class App
    def self.find(id)
      Okta.get("/apps/#{id}")
    end
    
    # /api/v1/apps/:aid/users/:uid
    def self.update(aid, uid, data)
      data = {profile: {data}}
      Okta.post("/apps/#{aid}/users/#{uid}", data)
    end
  end
end
