require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(name: "Example Guy", email: "guy@someplace.com", password: "password",
                                                                      password_confirmation: "password")
  end

  test "user should be valid" do
    assert @user.valid?
  end

  test "user name should be present" do
    @user.name = ""
    assert_not @user.valid?
  end

  test "user email should be present" do
    @user.email = ""
    assert_not @user.valid?
  end

  test "user name should not be too long" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end

  test "user email should not be too long" do
    @user.email = "a" * 250 + "@test.com"
    assert_not @user.valid?
  end

  test "user email should have valid format" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid|
      @user.email = valid
      assert @user.valid?, "#{valid.inspect} should be valid"
    end
  end

  test "invalid user email format should be rejected" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example. foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid|
      @user.email = invalid
      assert_not @user.valid?, "#{invalid.inspect} should be rejected"
    end
  end

  test "email addresses should be unique" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end

  test "email should be saved as lower case" do
    mixed_case_email = "FlOrEs@Oviedo.COM"
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end

  test "password should not be blank" do
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end

  test "password should be at least 6 characters" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end
end
