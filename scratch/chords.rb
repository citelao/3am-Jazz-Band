#!/usr/bin/env ruby

# basically the Unimidi example!
require "unimidi"
require_relative "../Note"

# Prompts the user to select a midi output
# Sends some arpeggiated chords to the output

notes = Note.new("d2 f#2 a2 c#3").pitches
octaves = 5
duration = 1

# Prompt the user to select an output
output = UniMIDI::Output.gets

def chord(output, array, duration)
	array.map do |note|
		output.puts(0x90, note + 24, 100) # note on
	end
	sleep(duration)
	array.map do |note|
		output.puts(0x80, note + 24, 100) # note off
	end
end

50.times do
	chord(output, notes, duration)
	sleep(duration)
	#chord(output, notes, duration)
end

# # using their selection...
# (0..((octaves-1)*12)).step(12) do |oct|

#   notes.each do |note|

#     output.puts(0x90, note + oct, 100) # note on
#     sleep(duration) # wait
#     output.puts(0x80, note + oct, 100) # note off

#   end

# end
