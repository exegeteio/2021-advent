# frozen_string_literal: true

require './day_two'
data = File.readlines('spec/day_two_data.txt')

RSpec.describe DayTwo do
  subject { described_class.new(data) }
  it 'part_one' do
    expect(subject.part_one).to be 150
  end

  it 'part_two' do
    expect(subject.part_two).to be 900
  end
end
