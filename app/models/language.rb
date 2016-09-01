class Language < ApplicationRecord
  belongs_to :repository, inverse_of: :languages
  #validates_presence_of :repository_id
end
