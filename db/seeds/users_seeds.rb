class CreateUsersSeeds
  def self.generate_users
    users = [
      { username: "shante", password: "123456" },
      { username: "carl", password: "123456" },
      { username: "hiro", password: "123456" },
      { username: "cedrine", password: "123456"}
    ]

    users.each do |user|
      User.create!(
        username: user[:username],
        password: user[:password]
      )
    end
  end
end
