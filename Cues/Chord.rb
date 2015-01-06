require_relative 'Note'

class Chord
	def initialize(pitches, velocity, duration)
		starts = Array.new
		stops = Array.new
		pitches.map do |pitch|
			n = Note.new(pitch, velocity, duration)
			starts += n.startCue.commands
			stops += n.stopCue.commands
		end

		@start = Cue.new(starts, 0)
		@stop = Cue.new(stops, duration)

		@cues = [@start, @stop]
	end

	def cues
		@cues
	end

end