module LoginMacros

  def sign_in(user)
    visit root_path
    find_link("Log in").click
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: "foobar"
    click_button 'Log in'
  end
end
