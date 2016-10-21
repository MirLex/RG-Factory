module TerminalShow
	def putSeparator(message = '',length = 80)
		length.times{print '_'}
		puts "\n" + message.to_s 
	end
end