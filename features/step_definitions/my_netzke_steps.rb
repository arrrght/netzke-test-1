Then /^button "([^"]*)" should be enabled$/ do |arg1|
  page.driver.browser.execute_script(<<-JS).should == true
    var btn = Ext.ComponentMgr.all.filter('text', '#{arg1}').filter('type','button').first();
  return typeof(btn)!='undefined' ? !btn.disabled : false
  JS
end

Then /^button "([^"]*)" should be disabled$/ do |arg1|
  page.driver.browser.execute_script(<<-JS).should == true
    var btn = Ext.ComponentMgr.all.filter('text', '#{arg1}').filter('type','button').first();
    return typeof(btn)!='undefined' ? btn.disabled : false
  JS
end

Given /^I have a user named "([^"]*)" with password "([^"]*)"$/ do |arg1, arg2|
  User.create!( :login => arg1, :password => arg2 )
end

When /^I wait for the response from the server$/ do
  page.wait_until{ page.driver.browser.execute_script("return !Ext.Ajax.isLoading();") }
end

When /I sleep (\d+) seconds?/ do |arg1|
  sleep arg1.to_i
end
