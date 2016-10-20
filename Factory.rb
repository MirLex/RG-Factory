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

            class_eval &block if block_given?
        end
    end
end