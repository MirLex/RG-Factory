class Factory
    def self.new(*args)
        p args
        gen_class
    end

    def self.gen_class
        Class.new
    end
end