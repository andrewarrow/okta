module Okta
  class App
    def self.find(id)
      Okta.get("/apps/#{id}")
    end
    
    # /api/v1/apps/:aid/users/:uid
    def self.update(aid, uid, data)
      data = {profile: data}
      Okta.post("/apps/#{aid}/users/#{uid}", data)
    end

    def self.get(aid, uid)
      Okta.get("/apps/#{aid}/users/#{uid}")
    end
  end
end
