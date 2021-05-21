require 'capybara/rspec'
require 'selenium-webdriver'

Capybara.register_driver :selenium_chrome_headless do |app|
  browser_options = Selenium::WebDriver::Chrome::Options.new
  browser_options.args << '--headless'
  browser_options.args << '--disable-gpu'
  browser_options.args << '--no-sandbox'

  Capybara::Selenium::Driver.new(
    app, browser: :chrome, options: browser_options, timeout: 600 # これ
  ).tap do |driver|
    driver.browser.manage.window.size = Selenium::WebDriver::Dimension.new(
      1440, 990
    )
  end
end

Capybara.javascript_driver = :selenium_chrome_headless
