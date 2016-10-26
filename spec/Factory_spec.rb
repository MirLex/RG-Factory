require_relative('../Factory')
RSpec.describe Factory do
  subject(:facroty_obj) { FactoryClass.new('John Smith', '123 Maple, Anytown NC', 12_345) }
  subject(:other_facroty_obj) { FactoryClass.new('John Smith', '123 Maple, Anytown NC', 12_345) }
  subject(:struct_obj) { StructClass.new('John Smith', '123 Maple, Anytown NC', 12_345) }

  before(:all) do
    FactoryClass = Factory.new(:name, :address, :zip) do
      def greeting
        "Hello #{name}!"
      end
    end

    StructClass = Struct.new(:name, :address, :zip) do
      def greeting
        "Hello #{name}!"
      end
    end
  end

  context '.new' do
    it 'create new FactoryClass' do
      expect(FactoryClass.class).to eq(Class)
    end
  end

  context '#initialize' do
    it 'create new instance of FactoryClass' do
      expect(facroty_obj.class).to eq(FactoryClass)
    end
  end

  context '#attr_reader' do
    it 'should return facroty_obj.name' do
      expect(facroty_obj.name).to eq('John Smith')
      expect(facroty_obj.name).to eq(struct_obj.name)
    end

    it 'should return facroty_obj.address' do
      expect(facroty_obj.address).to eq('123 Maple, Anytown NC')
      expect(facroty_obj.address).to eq(struct_obj.address)
    end

    it 'should return facroty_obj.zip' do
      expect(facroty_obj.zip).to eq(12_345)
      expect(facroty_obj.zip).to eq(struct_obj.zip)
    end
  end

  context '#[]' do
    it 'should return facroty_obj[:name]' do
      expect(facroty_obj[:name]).to eq('John Smith')
      expect(facroty_obj[:name]).to eq(struct_obj[:name])
    end
    it 'should return facroty_obj[:address]' do
      expect(facroty_obj[:address]).to eq('123 Maple, Anytown NC')
      expect(facroty_obj[:address]).to eq(struct_obj[:address])
    end
    it 'should return facroty_obj[:zip]' do
      expect(facroty_obj[:zip]).to eq(12_345)
      expect(facroty_obj[:zip]).to eq(struct_obj[:zip])
    end

    it 'should return facroty_obj[\'name\']' do
      expect(facroty_obj['name']).to eq('John Smith')
      expect(facroty_obj['name']).to eq(struct_obj['name'])
    end
    it 'should return facroty_obj[\'address\']' do
      expect(facroty_obj['address']).to eq('123 Maple, Anytown NC')
      expect(facroty_obj['address']).to eq(struct_obj['address'])
    end
    it 'should return facroty_obj[\'zip\']' do
      expect(facroty_obj['zip']).to eq(12_345)
      expect(facroty_obj['zip']).to eq(struct_obj['zip'])
    end

    it 'should return facroty_obj[0]' do
      expect(facroty_obj[0]).to eq('John Smith')
      expect(facroty_obj[0]).to eq(struct_obj[0])
    end
    it 'should return facroty_obj[1]' do
      expect(facroty_obj[1]).to eq('123 Maple, Anytown NC')
      expect(facroty_obj[1]).to eq(struct_obj[1])
    end
    it 'should return facroty_obj[2]' do
      expect(facroty_obj[2]).to eq(12_345)
      expect(facroty_obj[2]).to eq(struct_obj[2])
    end
  end

  context '#[]=' do
    it 'should set facroty_obj[:name]' do
      facroty_obj[:name] = 'Ron'
      expect(facroty_obj[:name]).to eq('Ron')
    end
    it 'should set facroty_obj[:address]' do
      facroty_obj[:address] = 'Addr'
      expect(facroty_obj[:address]).to eq('Addr')
    end
    it 'should set facroty_obj[:zip]' do
      facroty_obj[:zip] = 'Zip'
      expect(facroty_obj[:zip]).to eq('Zip')
    end

    it 'should set facroty_obj[\'name\']' do
      facroty_obj['name'] = 'Ron'
      expect(facroty_obj[:name]).to eq('Ron')
    end
    it 'should set facroty_obj[\'address\']' do
      facroty_obj['address'] = 'Addr'
      expect(facroty_obj[:address]).to eq('Addr')
    end
    it 'should set facroty_obj[\'zip\']' do
      facroty_obj['zip'] = 'Zip'
      expect(facroty_obj[:zip]).to eq('Zip')
    end

    it 'should set facroty_obj[0]' do
      facroty_obj[0] = 'Ron'
      expect(facroty_obj[:name]).to eq('Ron')
    end
    it 'should set facroty_obj[1]' do
      facroty_obj[1] = 'Addr'
      expect(facroty_obj[:address]).to eq('Addr')
    end
    it 'should set facroty_obj[2]' do
      facroty_obj[2] = 'Zip'
      expect(facroty_obj[:zip]).to eq('Zip')
    end
  end

  context '#eql?' do
    it 'should elq to other obj' do
      expect(facroty_obj.eql?(other_facroty_obj)).to eq(true)
    end
  end

  context '#each' do
    it 'should exec block to each attr' do
      expect(facroty_obj.each { |x| x }).to eq(['John Smith', '123 Maple, Anytown NC', 12_345])
    end
  end

  context '#each_pair' do
    it 'should exec block to each_pair attr => attr[val]' do
      expect(facroty_obj.each_pair { |name, value| "#{name} => #{value}" }).to eq(name: 'John Smith', address: '123 Maple, Anytown NC', zip: 12_345)
    end
  end

  context '#hash' do
    it 'should return hash' do
      expect(facroty_obj.hash.class).to eq(Fixnum)
    end
  end

  context '#length' do
    it 'should return length attrs' do
      expect(facroty_obj.length).to eq(3)
      expect(facroty_obj.length).to eq(struct_obj.length)
    end
  end

  context '#members' do
    it 'should return array of facroty_obj arrt' do
      expect(facroty_obj.members).to eq([:name, :address, :zip])
      expect(facroty_obj.members).to eq(struct_obj.members)
    end
  end

  context '#to_s' do
    it 'should return string of facroty_obj inspect' do
      expect(facroty_obj.to_s).to match(/@name=\"John Smith\", @address=\"123 Maple, Anytown NC\", @zip=12345/)
    end
  end

  context '#values' do
    it 'should return array of facroty_obj values' do
      expect(facroty_obj.values).to eq(['John Smith', '123 Maple, Anytown NC', 12_345])
      expect(facroty_obj.values).to eq(struct_obj.values)
    end
  end

  context '#values_at' do
    it 'should return values at positon' do
      expect(facroty_obj.values_at(1..2)).to eq(['123 Maple, Anytown NC', 12_345])
      expect(facroty_obj.values_at(1..2)).to eq(struct_obj.values_at(1..2))
    end
  end

  context '#select' do
    it 'should exec select block to each attr[val]' do
      expect(facroty_obj.select { |val| val if defined?(val) }).to eq(['John Smith', '123 Maple, Anytown NC', 12_345])
    end
  end

  context '#greeting' do
    it 'should exec block to Class' do
      expect(facroty_obj.greeting).to eq('Hello John Smith!')
      expect(facroty_obj.greeting).to eq(struct_obj.greeting)
    end
  end
end
