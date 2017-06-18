class GoodOrder < ActiveRecord::Base
  belongs_to :good
  belongs_to :order, inverse_of: :good_orders

  validates :good, presence: true
  validates :order, presence: true
  validates :digit, presence: true

end
