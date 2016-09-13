class Repository < ApplicationRecord
  include PgSearch
  self.per_page = 1
  is_impressionable
  has_many :languages, inverse_of: :repository, dependent: :destroy
  has_many :favourites, dependent: :destroy
  has_many :users, through: :favourites
  has_attached_file :poc_image, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "default.png",
                      url: "/system/:id/:style/:filename"
  accepts_nested_attributes_for :languages
  validates_attachment_content_type :poc_image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

  #searching by tags using actastaggable gem
  acts_as_taggable
  acts_as_taggable_on :tags_for_repository

  pg_search_scope :search_by_all,
	 :against => [:name, :author_name, :description],
   :using => { :tsearch => {:prefix => true} }

  def self.search_repo(key_word, language)
    condition_for_key_word = "name LIKE '%#{key_word}%' OR author_name LIKE '%#{key_word}%' OR description LIKE '%#{key_word}%'"
    result = key_word.present? ? where(condition_for_key_word) : all
    result = result.select{ |repo| repo.languages.select{|l| l.name == language}.present? } if language.present?
    result
  end
end
