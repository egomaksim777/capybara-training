module Helpers
  def login_with(email, password)
    email
  end

  def login_as_admin
    login_with 'admin@mail.com', 'password1234'
  end

  def login_as_user
    login_with 'user@mail.com', 'password1234'
  end
end
