class NewsletterData
  def self.mostly_viewed_pocs
    @viewed_pocs = Repository.all.sort_by { |repo| repo.impressions.count }.reverse[0..4]
  end

  def self.mostly_bookmarked_pocs
    @all_bookmarked_pocs = Repository.all.sort_by { |repo| repo.favourites.count }.reverse[0..4]
    @left_bookmarked_pocs = @all_bookmarked_pocs - @viewed_pocs
  end

  def self.latest_pocs
    @all_latest_pocs = Repository.last(5)
    @left_latest_pocs = @all_latest_pocs - @left_bookmarked_pocs
  end
end
