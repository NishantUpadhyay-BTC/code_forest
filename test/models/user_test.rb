require 'test_helper'
require 'fake_json_responses'

class UserTest < ActiveSupport::TestCase
  include FakeJsonResponses

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
    User.create_with_omniauth(auth_response)
    assert total_users + 1, User.count
    assert_equal auth_response["uid"], User.last.uid
    assert_equal auth_response["info"]["nickname"], User.last.name
  end

  test "repository_is_favourited" do
    @john.favourites.build(repository_id: @app1.id)
    @john.save
    assert @john.is_favourited?(@app1)
    assert_not @john.is_favourited?(repositories(:demo_app))
  end

  private

  def stub_request_response
    # WIP
  end
end
