require_relative('./Factory')

Customer = Struct.new(:name, :address, :zip) do 
  def greeting
    puts "Hello #{name}!"
  end
end

FactoryClass = Factory.new(:name, :address, :zip) do 
  def greeting
    puts "Hello #{name}!"
  end
end

joe = Customer.new('Joe Smith', '123 Maple, Anytown NC', 12345)
john = FactoryClass.new('John Smith', '123 Maple, Anytown NC', 12345)
# p john.inspect
# p john.name
# p john['name']
# p john[:name]
# p john[0]
# john[0] = 'Don Smith'
# p john.name
# john[:name] = 'Ron Smith'
# p john.name
# john['name'] = 'Joe Smith'
# p john.name
# p john.greeting
# p john.values
# p john.values[1..2]
# john.each {|x| p "#{x.class}"}
# john.each_pair{|name, value| p("#{name} => #{value}") }
p john.size
p john.length


# => #<struct Customer name="Joe Smith", address="123 Maple, Anytown NC", zip=12345>

# p joe.name       # => "Joe Smith"
# p joe['name']    # => "Joe Smith"
# p joe[:name]     # => "Joe Smith"
# p joe[0]         # => "Joe Smith"
# p joe.greeting   # => "Hello Joe Smith!"
# joe['name'] = 'John Smith'
# p joe[0]         # => "John Smith"
# joe.each {|x| p (x) }
# joe.each_pair {|name, value| p("#{name} => #{value}") }
# p joe.eql?(john)
# p joe.hash
# p john.hash
p joe.length
p joe.size
# p joe.members
# joe.select {|val| p val if val.is_a?(Fixnum)}
# p joe.to_a[1..2]
# p joe.values_at(1..2)
# p joe.values
# p joe.to_s
# p joe.inspect


# https://ru.wikibooks.org/wiki/Ruby/%D0%A1%D0%BF%D1%80%D0%B0%D0%B2%D0%BE%D1%87%D0%BD%D0%B8%D0%BA/Struct
# Методы класса
# new
# Методы объекта
# []=, [], ==, each_pair, each, eql?, hash, inspect, length, members, select, size, to_a, to_s, values_at, values