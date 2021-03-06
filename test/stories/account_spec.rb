require_relative '../story_helper.rb'

describe "AppStory" do
  before do
    Account.all.destroy
  end

  it "successfully creates an account" do
    post('/account/create/', '{
      "name" : "Account Test",
      "password" : "passw0rd"}')

    last_response.body.must_equal("Account successfully created.")
  end

  it "a duplicate account won't be created" do
    post('/account/create', '{
      "name" : "Account Test",
      "password" : "passw0rd"}')

    post('/account/create', '{
      "name" : "Account Test",
      "password" : "passw0rd"}')

    last_response.body.must_equal("Account with this name already exists.")
  end

  it "successfully logs in" do
    post('/account/create', '{
      "name" : "Account Test",
      "password" : "passw0rd"}')

    post('/account/login', '{
      "name" : "Account Test",
      "password" : "passw0rd"}')

    last_response.body.must_equal("You are now logged in.")
  end

  it "fails to log in if we supply the wrong credentials" do
    post('/account/create', '{
      "name" : "Account Test",
      "password" : "passw0rd"}')

    post('/account/login', '{
      "name" : "Account Test",
      "password" : "passw0rdd"}')

    last_response.body.must_equal("Login failed. Name/password not found.")
  end

end
