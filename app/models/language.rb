class Language < ApplicationRecord
  belongs_to :repository, inverse_of: :languages
end
