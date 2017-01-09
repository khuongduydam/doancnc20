class Cart < ApplicationRecord
  has_many :order_items, dependent: :destroy

  def add_product(product_id)
    current_item = order_items.find_by(product_id: product_id)
    if current_item
      current_item.quantity += 1
    else
      current_item = order_items.build(product_id: product_id)
    end
    current_item
  end

  def total_price(number=1)
    if number != 1
      order_items.to_a.sum{|item| item.total_price / number}
    else
      order_items.to_a.sum{|item| item.total_price}
    end
  end

  def paypal_url(return_url)
    values = {
      :business => 'ron-facilitator@vinova.sg',
      :cmd => '_cart',
      :upload => 1,
      :return => return_url,
      :invoice => id
    }
    order_items.each_with_index do |item, index|
      values.merge!({
        "amount_#{index+1}" => ((item.product.price.to_f) / 22700).round ,
        "item_name_#{index+1}" => item.product.name,
        "quantity_#{index+1}" => item.quantity
        })
    end
    "https://www.sandbox.paypal.com/cgi-bin/webscr?" + values.to_query
  end
end
