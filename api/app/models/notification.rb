# frozen_string_literal: true

class Notification < ApplicationRecord
  belongs_to :post, optional: true
  belongs_to :comment, optional: true

  belongs_to :visitor, presence: true, class_name: 'User', foreign_key: 'visitor_id', optional: true
  belongs_to :visited, presence: true, class_name: 'User', foreign_key: 'visited_id', optional: true
  default_scope -> { order(created_at: :desc) }
end
