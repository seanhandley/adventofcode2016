#!/usr/bin/env ruby

# --- Part Two ---
#
# With all the decoy data out of the way, it's time to decrypt this list and get moving.
#
# The room names are encrypted by a state-of-the-art shift cipher, which is nearly unbreakable without the right software. However, the information kiosk designers at Easter Bunny HQ were not expecting to deal with a master cryptographer like yourself.
#
# To decrypt a room name, rotate each letter forward through the alphabet a number of times equal to the room's sector ID. A becomes B, B becomes C, Z becomes A, and so on. Dashes become spaces.
#
# For example, the real name for qzmt-zixmtkozy-ivhz-343 is very encrypted name.
#
# What is the sector ID of the room where North Pole objects are stored?

require_relative "./advent4.1"

def letters
  ('a'..'z').to_a
end

def decrypt_room_name(room)
  room['name'].split('-').map do |word|
    word.chars.map do |c|
      cycle = letters.cycle
      ((letters.index(c) + room['id']) % 26).times { cycle.next }
      cycle.next
    end.join
  end.join " "
end

def target_name
  "northpole object storage"
end

puts real_rooms.find {|room| decrypt_room_name(room) == target_name}['id']
