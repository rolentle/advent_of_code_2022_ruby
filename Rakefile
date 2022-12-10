require 'active_support/all'

task :new_day, [:day_number, :class_name] do |t, args|
  spec_template = <<~HEREDOC
require "spec_helper"
require './lib/advent_2022'

describe 'day #{args.day_number}' do
  let(:example_input) do
    <<~\\HEREDOC
    \\HEREDOC
  end

  describe '.solution' do
    it 'returns for example' do
      expect(Advent2022::#{args.class_name.camelcase}.solution(example_input)).to eq(false)
      fixture_input = File.read('./spec/fixtures/day_#{args.day_number}_input.txt')
      expect(Advent2022::#{args.class_name.camelcase}.solution(fixture_input)).to eq(false)
    end
  end
end
  HEREDOC

  File.write("spec/day_#{args.day_number}_spec.rb", spec_template)

  class_template = <<~HEREDOC
# typed: strict

module Advent2022
  class #{args.class_name.camelcase}
    extend T::Sig
  end
end
  HEREDOC

  File.write("lib/advent_2022/#{args.class_name}.rb", class_template)
end
