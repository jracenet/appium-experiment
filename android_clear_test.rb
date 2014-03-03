require 'rspec'
require 'selenium-webdriver'

include Selenium::WebDriver


capabilities = {
      'device' => 'Android',
      'browserName' => '',
      'version' => '4.2',
      'app' => '/home/joan/workspace/appium-experiment/any_do.apk',
      'app-package' => 'com.xuchdeid.clear',
      'app-activity' => '.activity.ClearActivity'
  }

server_url = "http://127.0.0.1:4723/wd/hub"

describe "Clear" do

  before :all do
    @driver = Selenium::WebDriver.for(:remote, :desired_capabilities => capabilities, :url => server_url)
    @driver.manage.timeouts.implicit_wait = 20 # seconds
  end

  after :all do
    @driver.quit
  end

  it "remove a task from the default list" do
    tasks = @driver.find_elements(:tag_name, 'TextView')
    expect(tasks.length).to eq 2
    default_task = tasks[0]

    expect(default_task.attribute('text')).to eq 'the default list'
    @driver.execute_script 'mobile: swipe', endX: -default_task.size.width , endY: 0, duration: 1, element: default_task.ref

    expect(@driver.find_elements(:tag_name, 'TextView').length).to eq 1
  end

end