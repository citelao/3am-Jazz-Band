class Pitch
	@@ref = {
		0 => "c",
		1 => "c#",
		2 => "d",
		3 => "d#",
		4 => "e",
		5 => "f",
		6 => "f#",
		7 => "g",
		8 => "g#",
		9 => "a",
		10 => "a#",
		11 => "b"
	}

	def initialize(midiNumber)
		@midi = midiNumber
	end

	def midi
		@midi
	end

	def to_s
		octave = (@midi / 12) - 1
		note = @midi % 12

		"#{@@ref[note].upcase}#{octave}"
	end
end