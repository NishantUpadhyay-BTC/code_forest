module FakeJsonResponses
  def auth_response
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

  def repo_params
    {
      "repository" =>
      {
        "id"=>"",
        "author_name"=>"John-BTC",
        "avatar_url"=>"https://avatars.githubusercontent.com/u/6542029?v=3",
        "name"=>"demo_app",
        "description"=>"First demo app",
        "private"=>"false",
        "download_link"=>"https://github.com/John-BTC/demo_app/archive/master.zip",
        "clone_url"=>"https://github.com/John-BTC/demo_app.git",
        "git_url"=>"git://github.com/John-BTC/demo_app.git",
        "ssh_url"=>"git@github.com:John-BTC/demo_app.git",
        "svn_url"=>"https://github.com/John-BTC/demo_app",
        "no_of_stars"=>"0",
        "no_of_watchers"=>"0",
        "no_of_downloads"=>"",
        "no_of_views"=>"",
        "no_of_bookmarks"=>"",
        "has_wiki"=>"true",
        "wiki_url"=>"http://github.com//wiki",
        "repo_created_at"=>"2016-02-09T10:05:53Z",
        "last_updated_at"=>"2016-02-09T10:05:53Z",
        "tag_list"=>"bliss, guestUI, "
      }
    }
  end
end
