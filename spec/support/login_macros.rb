module LoginMacros

  def sign_in(user)
    visit root_path
    find_link('ENG').click
    find_link('Sign in').click
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: 'foobar'
    click_button 'Sign in'
  end
end
