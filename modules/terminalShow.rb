# frozen_string_literal: true
module TerminalShow
  def putSeparator(message = '', length = 80)
    length.times { print '_' }
    puts "\n" + message.to_s
  end
end
