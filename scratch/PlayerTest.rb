require 'unimidi'
require_relative '../Factories/ChordFactory'
require_relative '../Cues/Rest'
require_relative '../Player'
require_relative '../Cue'

tempo = 240 #bpm

$quarter = 60.0 / tempo
$eighth = $quarter / 2
$triplet = $quarter / 3

puts $quarter, $eighth, $triplet


# Prompt the user to select an output
output = UniMIDI::Output.gets

player = Player.new(output)

d = "d3 f#3 a3 c#4"
g = "g3 b3 d4 f#4"
a = "a3 c#4 e4 g4"

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

ChordFactory.chordFromNoteNames("d3 f#3 a3 c#4", 60, $quarter)

player.add([Cue.new([[0xFF, 0, 0]], 0)]) # reset

40.times do |i|
	player.add(jazz(d))
	player.add(jazz(g))
	player.add(jazz(d))
	player.add(first(a))
	player.add(second(g))
	player.add(jazz(d))
end

# puts player.cues

player.run