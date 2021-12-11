# frozen_string_literal: true

require './loader'

# Store the examples from the AoC website.
EXEMPLARS = {
  day_one: {
    part_one: 7,
    part_two: 5
  },
  day_two: {
    part_one: 150,
    part_two: 900
  },
  day_three: {
    part_one: 198,
    part_two: 230
  },
  day_four: {
    part_one: 4512,
    part_two: 1924
  }
}.freeze

# Load in the spec data provided.
Loader.load('spec/data/*.txt').each do |instance|
  # Describe this specific class
  RSpec.describe instance.klass do
    # Loop over the two parts to each question and build expectations.
    %i[part_one part_two].each do |part|
      it part do
        expect(instance.build.send(part)).to be(EXEMPLARS.dig(instance.ref, part))
      end
    end
  end # /RSpec
end # /Loader
