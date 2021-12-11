# frozen_string_literal: true

require 'active_support/all'

# Class for loading classes based on data files.
class Loader
  def self.load(glob)
    # Loop over the data directory.
    Dir.glob(glob).map do |datafile|
      basename = File.basename(datafile, '.txt')[3..]
      contents = File.readlines(datafile).map(&:chomp)
      require "./#{basename}"
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
