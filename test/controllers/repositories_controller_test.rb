require 'test_helper'

class RepositoriesControllerTest < ActionDispatch::IntegrationTest
  before do
    @app1 = repositories(:app1)
    stub_request(:get, "https://api.github.com/#{users(:john).name}/repos").
      with(:headers => {'Accept'=>'application/vnd.github.v3+json,application/vnd.github.beta+json;q=0.5,application/json;q=0.1', 'Accept-Charset'=>'utf-8', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Github API Ruby Gem 0.14.5'}).to_return(:status => 200, :body => "", :headers => {})
  end

  test "index" do
    get repositories_url
    assert_response 200
    assert_template :index
    assert assigns(:repositories)
    assert Repository.all.member?(assigns(:repositories).first)
    assert_equal 3, assigns(@repositories).count
  end

  test "show" do
    no_of_views = @app1.impressions.count
    get repository_url(id: @app1.id)
    assert_response 200
    assert assigns(:repository)
    assert_template :show
    assert_equal no_of_views + 1, @app1.impressions.count
  end

  test "new" do
  #   stub_request(:get, "https://api.github.com/john-btc/repos").
  # with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Host'=>'api.github.com', 'User-Agent'=>'Ruby'}).
  # to_return(:status => 200, :body => "", :headers => {})
  #   uri = URI.parse("https://api.github.com/#{users(:john).name}/repos")
  #   response = Net::HTTP.get(uri)
  #   get new_repository_url
  #   assert_response 200
  end

  test "edit" do
    get edit_repository_url(id: @app1.id)
    assert_response 200
    assert assigns(:repository)
    assert_equal @app1, assigns(:repository)
  end

  test "create" do
    # post repositories_url
  end

  test "update" do
    # put repository_url(id: @app1.id)
  end

  test "favourite" do
    # user = User.create_with_omniauth(auth)
    # # session[:user_id] = user.id
    # open_session do |sess|
    #   sess.get "/auth/github", user_id: user.id
    #   assert_redirected_to repositories_url, 'Expected redirect to root'
    # end
    # get repositories_favourite_url(id: @app1.id)

  end

  test "destroy" do

  end

  test "search" do

  end

  test "total_downloads" do
    no_of_downloads = @app1.no_of_downloads
    put total_downloads_repository_url(id: @app1.id)
    @app1.reload
    assert_equal no_of_downloads + 1, @app1.no_of_downloads
  end

  test "hide" do

  end

  def auth
    {
      "provider"=>"github",
      "uid"=>"123456",
      "info"=>
      {
        "nickname"=>"John-BTC",
        "email"=>"john@mail.com",
        "name"=>"John ",
        "image"=>"https://avatars.githubusercontent.com/u/123456?v=3",
        "urls"=>{"GitHub"=>"https://github.com/John-BTC", "Blog"=>nil}
      },
      "credentials"=>{"token"=>"dd2ea37e3fdc1277e7692f562bd4b66fb2dbc14b", "expires"=>false},
    }
  end
end
