json.array!(@receipts) do |receipt|
  json.extract! receipt, :rfc_emisor, :rfc_receptor, :concept, :ammount, :tax, :total
  json.url receipt_url(receipt, format: :json)
end
