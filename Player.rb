class Player

	def initialize(output)
		@output = output
		@cues = Array.new()
	end

	def run
		accumulator = 0
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
				if(accumulator > nextCue.offset)
					output.puts(nextCue.status, nextCue.db1, nextCue.db2)

					accumulator = 0
				end
			end

			if(@cues.length > 0)
				next

				if(cue > $quarter)
					puts cue
					value = (turnon) ? 0x90 : 0x80
					d.map do |note|
						output.puts(value, note, 60)
					end
					turnon = !turnon
					cue = 0
				end
			end

			last = current
		end
	end

	def add(cues)
		@cues.push(cues)
	end
end