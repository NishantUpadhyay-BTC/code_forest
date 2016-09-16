class Language < ApplicationRecord
  has_many :lang_repos
  has_many :repositories, through: :lang_repos
end
