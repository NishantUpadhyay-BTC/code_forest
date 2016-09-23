class Language < ApplicationRecord
  has_many :language_repositories
  has_many :repositories, through: :language_repositories
end
