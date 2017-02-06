module Okta
  class Auth
    def self.auth(email, password)
      data = {username: email, password: password}
      Okta.post("/authn", data)
    end

    def self.create_user(fname, lname, email, phone, password, question, answer)
      data = {"profile": {
          "firstName": fname,
          "lastName": lname,
          "email": email,
          "login": email,
          "mobilePhone": phone
        },
        "credentials": {
          "password": {"value": password },
          "recovery_question": { "question": question, "answer": answer }
        }
      }
      Okta.post("/users?activate=true", data)
    end
  end
end
