require 'unimidi'

require_relative '../Player'
require_relative '../Instrument'

require_relative '../Factories/PitchFactory'

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

piano.add(ChordFactory.chordFromIntervals("C3", "1 3 5 7 9", ))