require_relative('./Factory')
require_relative('modules/terminalShow.rb')
include TerminalShow

Customer = Struct.new(:name, :address, :zip) do 
  def greeting
    "Hello #{name}!"
  end
end

FactoryClass = Factory.new(:name, :address, :zip) do 
  def greeting
    "Hello #{name}!"
  end
end

joe = Customer.new('Joe Smith', '123 Maple, Anytown NC', 12345)
joe2 = Customer.new('Joe Smith', '123 Maple, Anytown NC', 12345)
john = FactoryClass.new('John Smith', '123 Maple, Anytown NC', 12345)
john2 = FactoryClass.new('Smith John', '123 Maple, Anytown NC', 12345)

# instance methods:
# []=, [], ==, each_pair, each, eql?, hash, inspect, length, members, select, size, to_a, to_s, values_at, values

meth = [:name, :address, :zip, :greeting, :hash, :length, :members, :to_s, :values, :inspect]
meth_with_val = {
    each:       Proc.new {|x| p "#{x.class}"}, 
    each_pair:  Proc.new {|name, value| p("#{name} => #{value}") },
    select:     Proc.new {|val| p val if val.is_a?(Fixnum)},
    values_at:  1,
    eql?:       john2,
}

john2['name'] = 'Don Smith'
john2['name']
john2[:name] = 'Ron Smith'
john2[0] = 'John Smith'

putSeparator('Start',120)

meth.each do |meth|
    putSeparator("Joe(Struct) call method #{meth}",120)
    p joe.send(meth)
    putSeparator("John(Factory) call method #{meth}",120)
    p john.send(meth)
end

meth_with_val.each do |meth,value|
    if value.is_a?(Proc)
        putSeparator("Joe(Struct) call method #{meth} with val #{value}",120)
        p joe.send(meth,&value)
        putSeparator("John(Factory) call method #{meth} with val #{value}",120)
        p john.send(meth,&value)
    else
        putSeparator("Joe(Struct) call method #{meth} with val #{value}",120)
        p joe.send(meth,value)
        putSeparator("John(Factory) call method #{meth} with val #{value}",120)
        p john.send(meth,value)
    end
end

putSeparator('END',120)