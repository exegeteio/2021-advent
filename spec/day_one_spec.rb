# frozen_string_literal: true

require './day_one'
data = File.read('spec/day_one_data.txt').split.map(&:to_i)

RSpec.describe DayOne do
  subject { described_class.new(data) }
  it 'part_one' do
    expect(subject.part_one).to be(7)
  end

  it 'part_two' do
    expect(subject.part_two).to be(5)
  end
end
