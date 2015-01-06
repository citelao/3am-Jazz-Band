class Instrument

	def initialize
		@cues = Array.new()
		@next = nil
	end

	def add(cues)
		@cues += cues

		if(@next == nil)
			@next = @cues.shift
		end
	end

	def next
		@next
	end

	def handle
		if(@cues.length > 0)
			@next = @cues.shift
		else 
			@next = nil
		end
	end
end