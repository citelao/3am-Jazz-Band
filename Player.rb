class Player

	def initialize(output, instruments)
		@output = output
		@cues = Array.new()
		@instruments = instruments
		@accumulators = Array.new(instruments.length)
	end

	def run
		@accumulators.map! do
			0
		end

		last = Time.now
		while true
			current = Time.now

			elapsed = current - last

			@accumulators.map! do |e|
				e + elapsed
			end

			@instruments.each_index do |i|
				instrument = @instruments[i]

				if instrument.next == nil
					instrument.handle
				end

				while instrument.next != nil && @accumulators[i] > instrument.next.offset
					instrument.next.commands.map do |command|
						@output.puts(command[0], command[1], command[2])
					end

					@accumulators[i] = 0

					instrument.handle
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