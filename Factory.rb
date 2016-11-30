class Factory
  def self.new(*args, &block)
    
    Class.new do
      attr_accessor(*args)

      define_method :initialize do |*ins_vals|
        raise ArgumentError, 'wrong number of arguments' if args.size != ins_vals.size
        args.zip(ins_vals).each { |arg, val| send("#{arg}=", val) }
      end

      define_method :[] do |attr|
        attr.is_a?(Numeric) ? send((args[attr]).to_s) : send(attr)
      end

      define_method :[]= do |attr, val|
        attr.is_a?(Numeric) ? send("#{args[attr]}=", val) : send("#{attr}=", val)
      end

      define_method :values do
        args.map { |attr| send(attr) }
      end

      define_method :each do |&block|
        values.each(&block)
      end

      define_method :each_pair do |&block|
        hash_attr_val.each(&block)
      end

      define_method :length do
        args.length
      end

      define_method :values_at do |index|
        values[index]
      end

      define_method :members do
        args
      end

      define_method :hash do
        hash_attr_val.hash
      end

      define_method :eql? do |other|
        self.class == other.class ? hash == other.hash : false
      end

      define_method :select do |&block|
        values.each(&block)
      end

      alias_method :size, :length
      alias_method :to_a, :values
      alias_method :to_s, :inspect
      alias_method :==, :eql?

      class_eval &block if block_given?

      private

      define_method :hash_attr_val do
        Hash[args.map { |attr| [attr, send(attr)] }]
      end
    end
  end
end
