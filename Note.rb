require_relative 'Cue'

class Note
	def initialize(pitch, velocity, duration)
		@start = Cue.new(
			[[0x90, pitch, velocity]],
			0)
		@stop = Cue.new(
			[[0x80, pitch, velocity]],
			duration)
		@cues = [@start, @stop]
	end

	def cues
		@cues
	end

	def startCue
		@start
	end

	def stopCue
		@stop
	end
end