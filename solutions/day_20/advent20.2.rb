#!/usr/bin/env ruby
#
# How many IPs are allowed by the blacklist?

require_relative './advent20.1'

p merged.each_cons(2).map {|a,b| b[0] - a[1] - 1}.reduce :+
