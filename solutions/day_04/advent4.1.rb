#!/usr/bin/env ruby

# --- Day 4: Security Through Obscurity ---
#
# Finally, you come across an information kiosk with a list of rooms. Of course, the list is encrypted and full of decoy data, but the instructions to decode the list are barely hidden nearby. Better remove the decoy data first.
#
# Each room consists of an encrypted name (lowercase letters separated by dashes) followed by a dash, a sector ID, and a checksum in square brackets.
#
# A room is real (not a decoy) if the checksum is the five most common letters in the encrypted name, in order, with ties broken by alphabetization. For example:
#
# aaaaa-bbb-z-y-x-123[abxyz] is a real room because the most common letters are a (5), b (3), and then a tie between x, y, and z, which are listed alphabetically.
# a-b-c-d-e-f-g-h-987[abcde] is a real room because although the letters are all tied (1 of each), the first five are listed alphabetically.
# not-a-real-room-404[oarel] is a real room.
# totally-real-room-200[decoy] is not.
#
# Of the real rooms from the list above, the sum of their sector IDs is 1514.
#
# What is the sum of the sector IDs of the real rooms?

def rooms
  @rooms ||= STDIN.read.split("\n").map{|room| parse_room room}
end

def parse_room(room)
  parts = room.scan(/([\w,\-]+)\-(\d+)\[(\w+)\]/)[0]
  parts[1] = parts[1].to_i
  Hash[['name','id','sum'].zip(parts)]
end

def occurrences(s)
  s.chars.inject({}) do |h, c|
    h[c] ||= 0
    h[c] += 1
    h
  end.to_a.sort{|x,y| y[1] <=> x[1]}
end

def checksum(name)
  occurrences(name.gsub('-','')).sort do |x,y|
    if x[1] == y[1]
      x[0] <=> y[0]
    else
      y[1] <=> x[1]
    end
  end.map{|c| c[0]}.take(5).join
end

def real_rooms
  rooms.select {|room| checksum(room['name']) == room['sum']}
end

if __FILE__ == $0
  puts real_rooms.map{|room| room['id']}.reduce(:+)
end
