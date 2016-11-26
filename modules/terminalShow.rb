module TerminalShow
  module ClassMethods
  end
  
  module InstanceMethods
    def putSeparator(message = '', length = 80)
      length.times { print '_' }
      puts "\n" + message.to_s
    end
  end
  
  def self.included(receiver)
    receiver.extend         ClassMethods
    receiver.send :include, InstanceMethods
  end
end
