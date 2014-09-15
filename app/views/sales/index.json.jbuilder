json.array!(@sales) do |sale|
  json.extract! sale, :id, :purchaser_name, :item_description, :item_price, :purchase_count, :merchant_address, :merchant_name
  json.url sale_url(sale, format: :json)
end
