class User < ApplicationRecord
  def self.authenticate(account, password)
    user = User.find_by_account(account)
    if user && user.password == password
      user
    else
      nil
    end
  end
end
