class Factory
    def self.new(*args)
        # p args
        gen_class(*args)
    end

    def self.gen_class(*args)
        Class.new  do
            attr_accessor(*args)
            
            define_method :initialize do |*ins_args|
                #TODO ArgumentError Wrong number of argument (args.l !=  ins_args)
                args.each_with_index do |arg,index|
                    send("#{arg}=", ins_args[index])
                end                
            end

            define_method :[] do |val|
                #TODO error if not Exist 
                val.is_a?(Fixnum) ? send("#{args[val]}") : send(val)
            end
        end
    end
end