# typed: strict
#
# module to determine Tuning Trouble for day 6
module Advent2022
  module TuningTrouble
    extend T::Sig

    sig { params(buffer: String).returns(Integer) }
    def self.marker(buffer)
      marker = T.let(nil, T.nilable(Integer))
      buffer.split('').each_cons(4).with_index do |sliced, index|
        if sliced == sliced.uniq
          marker = index + 4
          break
        end
      end

      T.must(marker)
    end

    sig { params(buffer: String).returns(Integer) }
    def self.messages(buffer)
      marker = T.let(nil, T.nilable(Integer))
      buffer.split('').each_cons(14).with_index do |sliced, index|
        if sliced == sliced.uniq
          marker = index + 14
          break
        end
      end

      T.must(marker)
    end
  end
end
