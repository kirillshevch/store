module OrderItemHelper
  def cart_status
    count = current_order.order_items.count
    if count == 0
      t('empty')
    else
      items = current_order.order_items
      price, count = 0, 0
        items.each do |val|
          price += val.book.price*val.quantity
        end
        items.each do |val|
          count += val.quantity
        end
      "(#{count}) #{number_to_currency(price)}"
    end
  end
end
