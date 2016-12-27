#!/usr/bin/env ruby

# --- Day 14: One-Time Pad ---
#
# In order to communicate securely with Santa while you're on this mission, you've been using a one-time pad that you generate using a pre-agreed algorithm. Unfortunately, you've run out of keys in your one-time pad, and so you need to generate some more.
#
# To generate keys, you first get a stream of random data by taking the MD5 of a pre-arranged salt (your puzzle input) and an increasing integer index (starting with 0, and represented in decimal); the resulting MD5 hash should be represented as a string of lowercase hexadecimal digits.
#
# However, not all of these MD5 hashes are keys, and you need 64 new keys for your one-time pad. A hash is a key only if:
#
# It contains three of the same character in a row, like 777. Only consider the first such triplet in a hash.
# One of the next 1000 hashes in the stream contains that same character five times in a row, like 77777.
#
# Considering future hashes for five-of-a-kind sequences does not cause those hashes to be skipped; instead, regardless of whether the current hash is a key, always resume testing for keys starting with the very next hash.
#
# For example, if the pre-arranged salt is abc:
#
# The first index which produces a triple is 18, because the MD5 hash of abc18 contains ...cc38887a5.... However, index 18 does not count as a key for your one-time pad, because none of the next thousand hashes (index 19 through index 1018) contain 88888.
# The next index which produces a triple is 39; the hash of abc39 contains eee. It is also the first key: one of the next thousand hashes (the one at index 816) contains eeeee.
# None of the next six triples are keys, but the one after that, at index 92, is: it contains 999 and index 200 contains 99999.
# Eventually, index 22728 meets all of the criteria to generate the 64th key.
#
# So, using our example salt of abc, index 22728 produces the 64th key.
#
# Given the actual salt in your puzzle input, what index produces your 64th one-time pad key?

require 'digest/md5'
require 'etc'
require 'parallel'
require 'drb/drb'

URI="druby://localhost:8787"

class HashCache
  def hashes
    @hashes ||= {}
  end
end

DRb.start_service(URI, HashCache.new)

def salt
  @salt ||= STDIN.read
end

def iterations
  1
end

def memoized_hashes
  @drb ||= DRbObject.new_with_uri(URI)
  @drb.hashes
end

def generate_hash(hash)
  if (res = memoized_hashes[[hash, iterations]])
    return res
  end
  start_hash = hash.dup
  iterations.times { hash = Digest::MD5.hexdigest(hash) }
  memoized_hashes[[start_hash, iterations]] = hash
  hash
end

def contains_run?(input, length, char=nil)
  input.chars.each_cons(length) do |section|
    if char
      return char if section.uniq.length == 1 && section[0] == char
    else
      return section[0] if section.uniq.length == 1
    end
  end
  false
end

def nprocessors
  @nprocessors ||= Etc.nprocessors
end

def is_key?(index)
  hash_1 = generate_hash("#{salt}#{index}")
  if char = contains_run?(hash_1, 3)
    rd, wr = IO.pipe
    results = Parallel.each((1..1000).to_a, in_processes: nprocessors) do |j|
      hash_2 = generate_hash("#{salt}#{index+j}")
      if contains_run?(hash_2, 5, char)
        rd.close
        wr.write hash_1
        wr.close
        raise Parallel::Kill
      end
      nil
    end

    wr.close
    ans = rd.read
    rd.close
    return ans if ans.length > 0
  end
  false
end

def debug(msg)
  print msg if DEBUG
end

def find_keys
  keys = []
  i = 0
  while true do
    if key = is_key?(i)
      key = {key: key, index: i}
      debug "\n"
      debug "#{keys.length+1}: #{key}\n"
      debug "#{memoized_hashes.length}\n"
      keys << key
    else
      debug '.'
    end
    return keys.last[:index] if keys.length == 64
    i += 1
  end
end

DEBUG = true
p find_keys if __FILE__ == $0
