class Language < ApplicationRecord
  has_many :lang_repos, inverse_of: :language
  has_many :repositories, through: :lang_repos, inverse_of: :language
end
