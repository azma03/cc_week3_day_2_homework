require("pry")
require_relative("./models/property_manager.rb")

# Property.delete_all()

property1 = Property.new({
  'address' => "1 High Street",
  'value' => 100000,
  'number_of_bedrooms' => 2,
  'status' => "buy"
  })

property1.save()

property2 = Property.new({
  'address' => "1 Hope Street",
  'value' => 1000,
  'number_of_bedrooms' => 3,
  'status' => "let"
  })

property2.save()

# property2.delete()

property2.value = 1500
property2.update()

# property_by_id = Property.find_by_id(3)
property_by_id = Property.find_by_id(property1.id)

property_by_address = Property.find_by_address("1 High Street")

properties = Property.all()

binding.pry
nil
