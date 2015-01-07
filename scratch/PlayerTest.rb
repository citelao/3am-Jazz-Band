require 'unimidi'
require_relative '../Factories/ChordFactory'
require_relative '../Cues/Rest'
require_relative '../Player'
require_relative '../Instrument'
require_relative '../Cue'

tempo = 120 #bpm

$quarter = 60.0 / tempo
$eighth = $quarter / 2
$triplet = $quarter / 3

puts $quarter, $eighth, $triplet


# Prompt the user to select an output
output = UniMIDI::Output.gets

piano = Instrument.new()
bass = Instrument.new()
player = Player.new(output, [piano, bass])

d = "f#3 a3 c#4 e4" # missing d3
g = "b3 d4 f#4 a4" # missing g3
a = "c#4 e4 g4 b4" # missing a3

def jazz(chord)
	[
		first(chord),
		second(chord)
	].flatten	
end

def first(chord)
	[
		ChordFactory.chordFromNoteNames(chord, 75, $quarter).cues,
		Rest.new(2 * $triplet).cues,
		ChordFactory.chordFromNoteNames(chord, 50, 1 * $triplet).cues,
		Rest.new(2 * $quarter).cues
	].flatten
end

def second(chord)
	[
		Rest.new(2 * $triplet).cues,
		ChordFactory.chordFromNoteNames(chord, 70, $quarter).cues,
		Rest.new(1 * $triplet).cues,
		ChordFactory.chordFromNoteNames(chord, 50, 1 * $triplet).cues,
		Rest.new($quarter + 2 * $triplet).cues
	].flatten
end

piano.add([Cue.new([[0xFF, 0, 0]], 0)]) # reset

40.times do |i|
	piano.add(jazz(d))
	piano.add(jazz(g))
	piano.add(jazz(d))
	piano.add(first(a))
	piano.add(second(g))
	piano.add(jazz(d))

	8.times do
		bass.add(ChordFactory.chordFromNoteNames("d3", 70, $quarter, 2).cues)
	end

	8.times do
		bass.add(ChordFactory.chordFromNoteNames("g2", 70, $quarter, 2).cues)
	end

	8.times do
		bass.add(ChordFactory.chordFromNoteNames("d3", 70, $quarter, 2).cues)
	end

	4.times do
		bass.add(ChordFactory.chordFromNoteNames("a2", 70, $quarter, 2).cues)
	end

	4.times do
		bass.add(ChordFactory.chordFromNoteNames("g2", 70, $quarter, 2).cues)
	end

	8.times do
		bass.add(ChordFactory.chordFromNoteNames("d3", 70, $quarter, 2).cues)
	end
end

# puts player.cues

player.run