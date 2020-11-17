module LoginSupport
  def valid_guest_login(_user)
    visit root_path
    find('.nav-icon-btn').click
    find('.login').click

    click_link 'ゲストユーザーでログインする'
  end
end

RSpec.configure do |config|
  config.include LoginSupport
end
