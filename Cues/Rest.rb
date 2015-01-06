require_relative '../Cue'

class Rest
	def initialize(duration)
		@cue = Cue.new(
			[0, 0, 0],
			duration)
	end

	def cues
		[@cue]
	end
end