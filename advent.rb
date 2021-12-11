#!/usr/bin/env ruby
# frozen_string_literal: true

require 'rubygems'
require 'bundler/setup'
require 'active_support/all'
require './loader'

PARTS = {
  part_one: 'One',
  part_two: 'Two'
}.freeze

Loader.load('data/*.txt').each do |instance|
  PARTS.each_pair do |method, label|
    puts "#{instance.title} Part #{label}: #{instance.build.send(method)}"
  end
end
