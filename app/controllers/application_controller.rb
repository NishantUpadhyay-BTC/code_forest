require 'will_paginate/array'
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  protect_from_forgery with: :exception
  helper_method :current_user

  def filter_pocs(repositories)
    poc_names = Repository.where(author_name: current_user.name).pluck(:name)
    repositories.select{ |repo| !poc_names.include?(repo[:name]) }
  end

  def sort_data(resources, sort_by, sort_order, page, associative_column=false)
    if associative_column
      resources = sort_with_association(resources, sort_by)
    elsif resources.class == Array && sort_by.present?
      resources = resources.sort_by { |resource| resource[sort_by] }
    else
      resources = resources.order(sort_by)
    end
    resources = (sort_order == "ASC") ? resources : resources.reverse
    paginated(resources, page)
  end

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def sort_with_association(resources, sort_by)
    resources = resources.sort_by { |resource| resource.send(sort_by).count }
  end

  def paginated(resources, page)
    resources.paginate(per_page: 3, page: page)
  end
end
