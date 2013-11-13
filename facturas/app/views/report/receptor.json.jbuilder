json.array!(@receipts) do |receipt|
  json.extract! receipt, 'emisor', 'receptor', 'total'
end