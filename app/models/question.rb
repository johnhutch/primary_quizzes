class Question < ActiveRecord::Base
  belongs_to :user
  has_many :choices

  accepts_nested_attributes_for :choices
end
