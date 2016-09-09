class User < ApplicationRecord
  has_many :favourites
  has_many :repositories, through: :favourites

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.name = auth["info"]["nickname"]
      user.email = auth["info"]["email"]
      user.avtar_url = auth["info"]["image"]
      user.github_url = auth["info"]["urls"]["GitHub"]
    end
  end

  def is_favourited?(repository)
    favourites.find_by_repository_id(repository.id)
  end
end
