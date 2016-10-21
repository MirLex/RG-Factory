class Factory
    def self.new(*args, &block)
        gen_class(*args,&block)
    end

    def self.gen_class(*args,&block)
        Class.new  do
            attr_accessor(*args)
            
            define_method :initialize do |*ins_args|
                #TODO ArgumentError Wrong number of arguments (args.l !=  ins_args)
                args.each_with_index do |arg,index|
                    send("#{arg}=", ins_args[index])
                end                
            end

            define_method :[] do |attr|
                #TODO error if not Exist 
                attr.is_a?(Fixnum) ? send("#{args[attr]}") : send(attr)
            end

            define_method :[]= do |attr , val|
                attr.is_a?(Fixnum) ? send("#{args[attr]}=",val) : send("#{attr}=",val)
            end

            define_method :values do
                args.map{|attr| send(attr)}
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

            define_method :members  do
                args
            end

            define_method :hash do
                hash_attr_val.hash
            end

            define_method :eql? do |other|
                self.class == other.class ? hash == other.hash : false
            end
            
            alias :size :length
            alias :to_a :values
            alias :to_s :inspect
            alias :==   :eql?

            class_eval &block if block_given?
            
            private
            define_method :hash_attr_val do
                Hash[ args.map { |attr| [attr, send(attr)]} ]
            end
        end
    end
end