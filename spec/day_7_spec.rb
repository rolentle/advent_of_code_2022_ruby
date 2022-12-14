require "spec_helper"
require './lib/advent_2022'

describe 'day 7' do
  let(:example_input) do
    <<~HEREDOC
$ cd /
$ ls
dir a
14848514 b.txt
8504156 c.dat
dir d
$ cd a
$ ls
dir e
29116 f
2557 g
62596 h.lst
$ cd e
$ ls
584 i
$ cd ..
$ cd ..
$ cd d
$ ls
4060174 j
8033020 d.log
5626152 d.ext
7214296 k
    HEREDOC
  end

  let(:visual_output) do
    <<~HEREDOC
- / (dir)
  - a (dir)
    - e (dir)
      - i (file, size=584)
    - f (file, size=29116)
    - g (file, size=2557)
    - h.lst (file, size=62596)
  - b.txt (file, size=14848514)
  - c.dat (file, size=8504156)
  - d (dir)
    - j (file, size=4060174)
    - d.log (file, size=8033020)
    - d.ext (file, size=5626152)
    - k (file, size=7214296)
    HEREDOC
  end

  describe '.visual_output' do
    it 'returns the example' do
      root, nodes_by_id = Advent2022::NoSpaceLeft.data_structure(terminal_output: example_input)
      expect(Advent2022::NoSpaceLeft.stringify(node: root, nodes_by_id: nodes_by_id, generation: 0)).to eq(visual_output.strip)
    end
  end

  describe '.size' do
    it 'returns the example' do
      root, nodes_by_id = Advent2022::NoSpaceLeft.data_structure(terminal_output: example_input)
      node = nodes_by_id['/a/e']
      expect(Advent2022::NoSpaceLeft.size(node: node, nodes_by_id: nodes_by_id)).to eq(584)
      node = nodes_by_id['/a']
      expect(Advent2022::NoSpaceLeft.size(node: node, nodes_by_id: nodes_by_id)).to eq(94_853)
      node = nodes_by_id['/d']
      expect(Advent2022::NoSpaceLeft.size(node: node, nodes_by_id: nodes_by_id)).to eq(24_933_642)

      expect(Advent2022::NoSpaceLeft.size(node: root, nodes_by_id: nodes_by_id)).to eq(48_381_165)
    end
  end

  describe '.solution' do
    it 'returns the example' do
      root, nodes_by_id = Advent2022::NoSpaceLeft.data_structure(terminal_output: example_input)
      expect(Advent2022::NoSpaceLeft.solution(nodes_by_id: nodes_by_id)).to eq(95_437)
    end

    it 'returns the fixture value' do
      fixture_input = File.read('./spec/fixtures/day_7_input.txt')
      root, nodes_by_id = Advent2022::NoSpaceLeft.data_structure(terminal_output: fixture_input)
      expect(Advent2022::NoSpaceLeft.solution(nodes_by_id: nodes_by_id)).to eq(1_845_346)
    end
  end

  describe '.solution_2' do
    it 'returns the example' do
      root, nodes_by_id = Advent2022::NoSpaceLeft.data_structure(terminal_output: example_input)
      expect(Advent2022::NoSpaceLeft.solution_2(nodes_by_id: nodes_by_id)).to eq(24_933_642)
    end

    it 'returns the fixture value' do
      fixture_input = File.read('./spec/fixtures/day_7_input.txt')
      root, nodes_by_id = Advent2022::NoSpaceLeft.data_structure(terminal_output: fixture_input)
      expect(Advent2022::NoSpaceLeft.solution_2(nodes_by_id: nodes_by_id)).to eq(3_636_703)
    end
  end
end
