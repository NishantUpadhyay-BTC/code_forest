class Repository < ApplicationRecord
  self.per_page = 3
  is_impressionable
  has_many :lang_repos, dependent: :destroy, inverse_of: :repository
  has_many :languages, through: :lang_repos, dependent: :destroy
  has_many :favourites, dependent: :destroy
  has_many :users, through: :favourites
  has_attached_file :poc_image, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "default.png",
                      url: "/system/:id/:style/:filename"
  accepts_nested_attributes_for :lang_repos
  validates_attachment_content_type :poc_image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
  validates :description, presence: true, length: { maximum: 300 }

  #searching by tags using actastaggable gem
  acts_as_taggable
  acts_as_taggable_on :tags_for_repository

  def self.search_repo(key_word, language)
    key_word = key_word.upcase
    condition_for_key_word = "repositories.hide != true AND (UPPER(repositories.name) LIKE '%#{key_word}%' OR UPPER(author_name) LIKE '%#{key_word}%' OR UPPER(description) LIKE '%#{key_word}%')"
    repositories = (language == 'All' || language.nil?) ? Repository.all : Language.find_by(name: language).repositories
    repositories = repositories.where(condition_for_key_word) if key_word.present?
    repositories
  end
end
