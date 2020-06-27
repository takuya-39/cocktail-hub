module LoginSupport
  def valid_login(user)
    visit root_path
    find('.nav-icon').click
    find('.signup').click
    fill_in 'UserName', with: user.username
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    fill_in 'PasswordConfirmation', with: user.password
    attach_file 'UserImage', "#{ Rails.root }/spec/support/assets/sample_user_image.jpg"
    click_button '新規ユーザー登録をする'
  end
end

RSpec.configure do |config|
  config.include LoginSupport
end
