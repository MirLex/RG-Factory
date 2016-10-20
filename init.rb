Customer = Struct.new(:name, :address, :zip) do 
  def greeting
    puts "Hello #{name}!"
  end
end
# => Customer

joe = Customer.new('Joe Smith', '123 Maple, Anytown NC', 12345)
# => #<struct Customer name="Joe Smith", address="123 Maple, Anytown NC", zip=12345>

puts joe.name       # => "Joe Smith"
puts joe['name']    # => "Joe Smith"
puts joe[:name]     # => "Joe Smith"
puts joe[0]         # => "Joe Smith"
puts joe.greeting   # => "Hello Joe Smith!"