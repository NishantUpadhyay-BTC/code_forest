class NewsletterData
  def call
    viewed_pocs = mostly_viewed_pocs
    bookmarked_pocs = mostly_bookmarked_pocs(viewed_pocs)
    recent_pocs = latest_pocs(viewed_pocs, bookmarked_pocs)
    newsletter_pocs = {
      viewed_pocs: viewed_pocs,
      bookmarked_pocs: bookmarked_pocs,
      latest_pocs: recent_pocs
    }
  end

  private

  def mostly_viewed_pocs
    Repository.all.sort_by { |repo| repo.impressions.count }.reverse[0..4]
  end

  def mostly_bookmarked_pocs(viewed_pocs)
    all_bookmarked_pocs = Repository.all.sort_by { |repo| repo.favourites.count }.reverse[0..4]
    all_bookmarked_pocs - mostly_viewed_pocs
  end

  def latest_pocs(viewed_pocs, bookmarked_pocs)
    all_latest_pocs = Repository.last(5)
    all_latest_pocs - viewed_pocs - bookmarked_pocs
  end
end
