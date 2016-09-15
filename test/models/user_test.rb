require 'test_helper'

class UserTest < ActiveSupport::TestCase
  before do
    @john = users(:john)
    @app1 = repositories(:app1)
  end

  test "user has many favourite repositories" do
    fav_repos_count = @john.favourites.count
    @john.favourites.build(repository_id: @app1.id)
    @john.save
    assert_equal @app1.id, @john.favourites.first.repository_id
    assert_equal fav_repos_count + 1, @john.favourites.count
  end

  test "create user with omniauth" do
    total_users = User.count
    User.create_with_omniauth(auth)
    assert total_users + 1, User.count
    assert_equal auth["uid"], User.last.uid
    assert_equal auth["info"]["nickname"], User.last.name
  end

  test "repository_is_favourited" do
    @john.favourites.build(repository_id: @app1.id)
    @john.save
    assert @john.is_favourited?(@app1)
    assert_not @john.is_favourited?(repositories(:demo_app))
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

  private

  def stub_request_response
    # stub_request(:get, "http://localhost:3000/auth/github/callback").
    #   with(query:
    #         {
    #           code: "476aea39d84ca85110ff",
    #           state: "782609ba6439a062f948f9b6eb8c3fe9abaad21f4e0f09d7"
    #         }
    #       )
    # uri = URI.parse('http://localhost:3000/auth/github/callback')
    # req = Net::HTTP::Get.new(uri.path)
    # # req['Header-Name'] = 'Header-Value'
    # Net::HTTP.start(uri.host, uri.port) {|http| http.request(req) }
    #   res = Net::HTTP.start(uri.host, uri.port) do |http|
    #     http.request(req, 'abc')
    #   end    # ===> Success
  end
end
