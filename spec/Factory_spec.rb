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
      expect(facroty_obj).to be_instance_of FactoryClass
    end
  end

  context '#attr_reader' do
    attributes = {
      'name'    => 'John Smith',
      'address' => '123 Maple, Anytown NC',
      'zip'     => 12_345
    }.each do |attr, val|
      it "return attribute value facroty_obj.#{attr} " do
        expect(facroty_obj.send(attr)).to eq(val)
        expect(facroty_obj.send(attr)).to eq(struct_obj.send(attr))
      end
    end
  end

  context '#[]' do
    attributes = {
      :name     => 'John Smith',
      'name'    => 'John Smith',
      0         => 'John Smith',
      :address  => '123 Maple, Anytown NC',
      'address' => '123 Maple, Anytown NC',
      1         => '123 Maple, Anytown NC',
      :zip      => 12_345,
      'zip'     => 12_345,
      2         => 12_345
    }.each do |attr, val|
      it "return facroty_obj[#{attr}] attr" do
        expect(facroty_obj[attr]).to eq(val)
        expect(facroty_obj[attr]).to eq(struct_obj[attr])
      end
    end
  end

  context '#[]=' do
    attributes = {
      :name     => 'Rons name by symbol',
      'name'    => 'Rons name by string',
      0         => 'Rons name by Fixnum',
      :address  => 'address by symbol',
      'address' => 'address by string',
      1         => 'address by Fixnum',
      :zip      => 'Zip by symbol',
      'zip'     => 'Zip by string',
      2         => 'Zip by Fixnum'
    }.each do |attr, val|
      it "set facroty_obj[#{attr}]= #{val} attr" do
        facroty_obj[attr] = val
        expect(facroty_obj[attr]).to eq(val)
      end
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
