require 'unimidi'
require_relative '../Note'
require_relative '../Rest'
require_relative '../Player'

tempo = 120 #bpm

$quarter = 60.0 / tempo
$eighth = $quarter / 2
$triplet = $quarter / 3

puts $quarter, $eighth, $triplet


# Prompt the user to select an output
output = UniMIDI::Output.gets

player = Player.new(output)

50.times do |i|
	player.add(Note.new(60 + i, 60, $eighth).cues)
	player.add(Rest.new($eighth).cues)
end

# puts player.cues

player.run