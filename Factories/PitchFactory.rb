require_relative '../Pitch'

class PitchFactory
	@@ref = {
		"c"  => 0,
		"d"  => 2,
		"e"  => 4,
		"f"  => 5,
		"g"  => 7,
		"a"  => 9,
		"b"  => 11
	}

	# Notes represented as a letter note name
	# can be converted here
	#
	# accepts: a1, A1, a#1, ab1, Abb1
	def PitchFactory.pitchFromNote(name)
		octave = Integer(name[-1])

		pitchName = name[0].downcase
		pitchNumber = @@ref[pitchName]

		mod = name[1...-1]
		
		if(!mod.empty?)
			mod.split("").each do |letter|
				if(letter == "b")
					pitchNumber -= 1
				end

				if(letter == "#")
					pitchNumber += 1
				end
			end
		end

		Pitch.new(pitchNumber + 12 * (octave + 1))
	end
end