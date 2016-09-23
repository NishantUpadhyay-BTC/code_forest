class LanguageRepository < ApplicationRecord
  belongs_to :repository, inverse_of: :language_repositories
  belongs_to :language, inverse_of: :language_repositories
end
