# frozen_string_literal: true

require 'active_support/all'

# Class for loading classes based on data files.
class Loader
  # Load in ruby files and AoC data.
  def self.load(glob)
    # Loop over the data directory.
    Dir.glob(glob).map do |datafile|
      # First three chars of the filename is for sorting, remove file extension and first 3 chars.
      basename = File.basename(datafile, '.txt')[3..]
      # Read in, chomp the lines, and strip the results.
      contents = File.readlines(datafile, chomp: true).map(&:strip)
      # Require the ruby file.
      require "./days/#{basename}"
      # Get a reference to the class and create an instance with a pretty title..
      klass = basename.classify.constantize
      Instance.new(klass, contents, basename.split(/\W/).map(&:titleize).join, basename.to_sym)
    end
  end

  # Hold info about each instance.
  Instance = Struct.new(:klass, :contents, :title, :ref) do
    def build
      klass.new(contents.clone)
    end
  end
end
