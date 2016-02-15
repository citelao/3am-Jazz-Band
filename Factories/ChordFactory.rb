require_relative '../Cues/Chord'
require_relative 'PitchFactory'

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
			midiNotes.push PitchFactory.pitchFromNote(note).midi
		end

		Chord.new(midiNotes, velocity, duration, channel)
	end

	# Doh I need to know about keys TODO
	# def ChordFactory.chordFromIntervals(key, numbers, duration, channel = 1)
	# 	midiNotes = Array.new()

	# 	base = PitchFactory.pitchFromNote(key).midi
	# 	intervals = numbers.split(" ")

	# 	intervals.each do |interval|
	# 		midiNotes.push base + interval
	# 	end

	# 	Chord.new(midiNotes, velocity, duration, channel)
	# end
end