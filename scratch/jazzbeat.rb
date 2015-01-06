require "unimidi"
require_relative "../NoteFactory"

tempo = 120 #bpm

$quarter = 60.0 / tempo
$eighth = $quarter / 2
$triplet = $quarter / 3

puts $quarter, $eighth, $triplet


# Prompt the user to select an output
output = UniMIDI::Output.gets

d = NoteFactory.new("d4 f#4 a4 c#5").pitches
g = NoteFactory.new("g4 b4 d5 f#5").pitches
a = NoteFactory.new("a4 c#5 e5 g5").pitches

def chord(output, array, duration, velocity)
	array.map do |note|
		output.puts(0x90, note, velocity) # note on
	end
	sleep(duration)
	array.map do |note|
		output.puts(0x80, note, velocity) # note off
	end
end

def jazz(output, chord)
	first(output, chord)
	second(output, chord)	
end

def first(output, chord)
	chord(output, chord, $quarter, 75)
	sleep(2 * $triplet)
	chord(output, chord, 1 * $triplet, 50)
	sleep($quarter + $quarter)
end

def second(output, chord)
	sleep(2 * $triplet)
	chord(output, chord, $quarter, 70)
	sleep(1 * $triplet)
	chord(output, chord, 1 * $triplet, 50)
	sleep($quarter + 2 * $triplet)
end

turnon = true
cue = 0
last = Time.now
while true
	current = Time.now

	elapsed = current - last

	cue += elapsed
	if(cue > $quarter)
		puts cue
		value = (turnon) ? 0x90 : 0x80
		d.map do |note|
			output.puts(value, note, 60)
		end
		turnon = !turnon
		cue = 0
	end

	last = current
end

# 50.times do
# 	chord(output, d, $quarter, 60)
# 	chord(output, d, $quarter, 50)
# 	chord(output, d, $quarter, 55)
# 	chord(output, d, $quarter, 55)
# end

# 50.times do
# 	jazz(output, d)
# 	jazz(output, d)

# 	jazz(output, g)

# 	jazz(output, d)

# 	first(output, a)
# 	second(output, g)

# 	jazz(output, d)
# end