module Okta
  class Auth
    def self.auth(email, password)
      data = {username: email, password: password}
      Okta.post("/authn", data)
    end
  end
end
