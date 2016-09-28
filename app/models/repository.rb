class Repository < ApplicationRecord
  self.per_page = Settings.pagination.default
  is_impressionable
  scope :unhide_repos, -> { where(hide: false) }
  has_many :language_repositories, dependent: :destroy, inverse_of: :repository
  has_many :languages, through: :language_repositories, dependent: :destroy
  has_many :favourites, dependent: :destroy
  has_many :users, through: :favourites
  has_attached_file :poc_image, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "default.png",
                      url: "/system/:id/:style/:filename"
  accepts_nested_attributes_for :language_repositories
  validates_attachment_content_type :poc_image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
  validates :description, presence: true, length: { maximum: 300 }

  #searching by tags using actastaggable gem
  acts_as_taggable
  acts_as_taggable_on :tags_for_repository

  def self.search_repo(key_word, language)
    key_word = "%#{key_word.upcase}%"
    condition_for_key_word = "repositories.hide != true AND (UPPER(repositories.name) LIKE ? OR UPPER(author_name) LIKE ? OR UPPER(description) LIKE ?)"
    repositories = (['All', 'Filter by'].include?(language) || language.nil?) ? Repository.all : Language.find_by(name: language).repositories
    repositories = repositories.where(condition_for_key_word, key_word, key_word, key_word) if key_word.present?
    repositories
  end
end
