require 'test_helper'

class RepositoryTest < ActiveSupport::TestCase
  before do
    @app1 = repositories(:app1)
  end

  test "description is required and maximum length should be 300" do
    assert @app1.valid?

    @app1.description = nil
    assert @app1.invalid?
    assert_match /can\'t be blank/, @app1.errors.messages[:description].first

    @app1.reload

    @app1.description = "d"*301
    assert @app1.invalid?
    assert_match /is too long/, @app1.errors.messages[:description].first
  end

  test "repository has many languages" do
    repo_languages = @app1.languages.count
    @app1.languages.build(name: "Ruby")
    @app1.save
    assert_equal repo_languages + 1, @app1.languages.count
  end

  test "search repo" do
    @app1.languages.build(name: "Ruby")
    @app1.save
    assert_equal @app1, Repository.search_repo("app1", "Ruby").first
    assert_equal @app1, Repository.search_repo("Foo", "Ruby").first
    assert_equal @app1, Repository.search_repo("my first app", "Ruby").first
  end
end
