require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  test "invalid signup information" do
    get signup_path
    assert_no_difference 'User.count' do # User.countがブロッック実行後にも変わらないかテスト
      post users_path, params: { user: { name:  "",
                                         email: "user@invalid",
                                         password:              "foo",
                                         password_confirmation: "bar" } }
    end
    assert_template 'users/new' #'users/new'がよばれるかテスト
    assert_select 'div.alert', 'The form contains 4 errors.'
    # assert_select 'div#error_explanation', 'The form contains 4 errors.'
  end

  test "valid signup information" do
    get signup_path
    assert_difference 'User.count', 1 do # User.countがブロッック実行後に１プラスされるかテスト
      post users_path, params: { user: { name:  "Example User",
                                         email: "user@example.com",
                                         password:              "password",
                                         password_confirmation: "password" } }
    end
    follow_redirect!
    assert_template 'users/show'
    assert_not flash.empty?
  end

end