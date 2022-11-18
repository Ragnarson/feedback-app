module Seed
  class UserCreator
    def create_and_save_users
      User.transaction do
        Seed.load_seed("users").each do |attributes|
          next if User.find_by(uid: attributes["uid"])
          create_user!(*attributes.values)
        end
      end
    end

    private

    def create_user!(uid, name, email)
      name = "#{name}"
      email = "#{email}"
      uid = "#{uid}"

      User.create!(
        provider: "google_oauth2",
        uid: uid,
        name: name,
        email: email,
        auth_info: {
          provider: "google_oauth2",
          uid: uid,
          info: {
            name: name,
            email: email,
          },
          credentials: {
            token: "123"
          },
          extra: {
            raw_info: {
              hd: "ragnarson.com"
            }
          }
        }
      )
    end
  end
end
