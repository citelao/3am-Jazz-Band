class Player

	def initialize(output)
		@output = output
		@cues = Array.new()
	end

	def run
		accumulator = 0
		nextCue = nil
		last = Time.now
		while true
			current = Time.now

			elapsed = current - last

			accumulator += elapsed

			if(nextCue == nil) 
				if(@cues.length > 0)
					nextCue = @cues.shift
				end
			else
				while(accumulator > nextCue.offset)
					nextCue.commands.map do |command|
						@output.puts(command[0], command[1], command[2])
					end

					accumulator = 0

					if(@cues.length > 0)
						nextCue = @cues.shift
					end
				end
			end

			last = current
		end
	end

	def add(cues)
		@cues += cues
	end

	def cues
		@cues
	end
end