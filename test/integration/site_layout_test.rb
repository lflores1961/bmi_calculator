require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  test "home page layout" do
   get root_path
   assert_template 'start_page/home'
   # assert_select "a[href=?]", sign_up
   
  end
end
