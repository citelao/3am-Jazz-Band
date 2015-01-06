require_relative '../Cues/Chord'

class ChordFactory
	@@ref = {
		"c"  => 0,
		"d"  => 2,
		"e"  => 4,
		"f"  => 5,
		"g"  => 7,
		"a"  => 9,
		"b"  => 11
	}

	def ChordFactory.chordFromNoteNames(string, velocity, duration, channel = 1)
		midiNotes = Array.new()

		notes = string.split(" ")

		notes.each do |note|
			octave = Integer(note[-1])
			pitchName = note[0]
			pitchNumber = @@ref[pitchName]

			mod = note[1...-1]
			
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

			midiNote = pitchNumber + 12 * (octave + 1)
			midiNotes.push midiNote
		end

		Chord.new(midiNotes, velocity, duration, channel)
	end
end