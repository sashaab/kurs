module GoodsHelper
  def good_options()
    arr = []
    Good.all.each do |g|
      arr << [g.title, g.id] if g.quantity_in_stock >= g.minimum_quantity
    end
    return arr
  end
end
