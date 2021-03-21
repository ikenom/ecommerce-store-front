class Types::LineItemAttributes < Types::BaseInputObject
  argument :product_id, ID, required: true, loads: Types::ProductType
  argument :quantity, Integer, required: true
end