require 'test_helper'
require 'fake_json_responses'

class RepositoriesControllerTest < ActionDispatch::IntegrationTest
  include FakeJsonResponses

  before do
    @app1 = repositories(:app1)
    stub_request(:get, "https://api.github.com/#{users(:john).name}/repos").
      with(:headers => {'Accept'=>'application/vnd.github.v3+json,application/vnd.github.beta+json;q=0.5,application/json;q=0.1', 'Accept-Charset'=>'utf-8', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Github API Ruby Gem 0.14.5'}).to_return(:status => 200, :body => "", :headers => {})
  end

  test "index" do
    get repositories_path
    assert_response 200
    assert_template :index
    assert assigns(:repositories)
    assert Repository.all.member?(assigns(:repositories).first)
    assert_equal 3, assigns(@repositories).count
  end

  test "show" do
    no_of_views = @app1.impressions.count
    get repository_path(id: @app1.id)
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
  #   get new_repository_path
  #   assert_response 200
  end

  test "edit" do
    get edit_repository_path(@app1.id)
    assert_response 200
    assert assigns(:repository)
    assert_equal @app1, assigns(:repository)
  end

  test "create repository using valid data" do
    total_repos = Repository.count
    post repositories_path, repo_params
    assert_redirected_to repositories_path
    assert total_repos + 1, Repository.count
    assert_match /POC is created successfully/, flash[:green]
  end

  test "create repository using invalid data" do
    total_repos = Repository.count
    invalid_repo_params = repo_params
    invalid_repo_params["repository"]["description"] = ""
    post repositories_path, invalid_repo_params
    assert_redirected_to new_repository_path(repo_name: invalid_repo_params["repository"]["name"], user_name: invalid_repo_params["repository"]["author_name"])
    assert total_repos, Repository.count
    assert_match /Description can\'t be blank/, flash[:red]
  end

  test "update" do
    created_repo_params = repo_params
    created_repo_params["repository"]["id"] = 1
    created_repo_params["repository"]["name"] = 'test_app'
    created_repo_params.merge(lang_repos_attributes)
    put repository_path(@app1.id), created_repo_params
    assert_redirected_to repositories_path
    assert_match /POC #{assigns(@repository)["repository"].name} updated successfully/, flash[:green]
  end

  test "favourite" do
    # user = User.create_with_omniauth(auth_response)
    # open_session do |sess|
    #   sess[:user_id] = user.id
    #   get repositories_favourite_path(id: @app1.id)
    #   # sess.get "/auth/github", {user_id: user.id}
    #   # assert_redirected_to repositories_path, 'Expected redirect to root'
    # end

  end

  test "destroy" do

  end

  test "search" do
    @app1.languages.build(name: "Ruby")
    @app1.save
    get search_repositories_path, params: { key_word: "app1", language: "Ruby", format: 'js' }, xhr: true, as: :js
    assert_response 200
    assert assigns(@repositories)["repositories"].include?@app1
  end

  test "total_downloads" do
    no_of_downloads = @app1.no_of_downloads
    put total_downloads_repository_path(@app1.id)
    @app1.reload
    assert_equal no_of_downloads + 1, @app1.no_of_downloads
  end

  test "hide" do
    put hide_repository_path(@app1.id)
    @app1.reload
    assert @app1.hide

    put hide_repository_path(@app1.id)
    @app1.reload
    assert_not @app1.hide
  end
end
