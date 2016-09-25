class LangRepo < ApplicationRecord
  belongs_to :repository, inverse_of: :lang_repos
  belongs_to :language, inverse_of: :lang_repos
end
