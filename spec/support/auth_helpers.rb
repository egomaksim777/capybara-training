module Helpers
  def login_with(email, password)
    fill_in 'Email', with: email
    fill_in 'Password', with: password
    email
  end

  def login_as_admin
    login_with 'admin@mail.com', 'password1234'
  end

  def login_as_user
    login_with 'user@mail.com', 'password1234'
  end
end
