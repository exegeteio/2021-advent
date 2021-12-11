#!/usr/bin/env ruby
# frozen_string_literal: true

require 'rubygems'
require 'bundler/setup'
require 'active_support/all'
require './loader'

# These are the parts to each day's work.
PARTS = {
  part_one: 'One',
  part_two: 'Two'
}.freeze

# Load in all the data and loop over each instance.
Loader.load('data/*.txt').each do |instance|
  PARTS.each_pair do |method, label|
    # And output the results.
    puts "#{instance.title} Part #{label}: #{instance.build.send(method)}"
  end
end
