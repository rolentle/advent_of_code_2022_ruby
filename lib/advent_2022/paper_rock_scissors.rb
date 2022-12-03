# typed: strict
#
# module to determine PaperRockScissors for day 2
module Advent2022
  module PaperRockScissors
    extend T::Sig
    # Defined choices for paper rocker scissors
    class Choice < T::Enum
      extend T::Sig
      enums do
        Paper = new
        Rock = new
        Scissors = new
      end

      sig { returns(Integer) }
      def score
        case self
        when Rock then 1
        when Paper then 2
        when Scissors then 3
        end
      end
    end

    class EndState < T::Enum
      extend T::Sig
      enums do
        Win = new
        Lose = new
        Draw = new
      end

      sig { returns(Integer) }
      def score
        case self
        when Win then 6
        when Lose then 0
        when Draw then 3
        end
      end
    end

    Game = T.type_alias { T::Array[T.nilable(Choice)] }

    sig { params(list_of_games: String).returns(T::Array[T.nilable(Integer)]) }
    def self.predicted_total_scores(list_of_games)
      games = predicted_encrypted_strategy_guide(list_of_games)
      games.map do |game|
        predicted_scores(game)
      end.transpose.map(&:sum)
    end

    sig { params(game: Game).returns(T::Array[T.nilable(Integer)]) }
    def self.predicted_scores(game)
      game.map { |x| T.must(x).score }.zip(T.must(predicted_game_results_scores(game))).map(&:sum)
    end

    sig { params(game: Game).returns(T.nilable(T::Array[Integer])) }
    def self.predicted_game_results_scores(game)
      player_1_choice, player_2_choice = game

      case [player_1_choice, player_2_choice]
      when [Choice::Rock, Choice::Rock] then [3, 3]
      when [Choice::Rock, Choice::Paper] then [0, 6]
      when [Choice::Rock, Choice::Scissors] then [6, 0]
      when [Choice::Paper, Choice::Rock] then [6, 0]
      when [Choice::Paper, Choice::Paper] then [3, 3]
      when [Choice::Paper, Choice::Scissors] then [0, 6]
      when [Choice::Scissors, Choice::Rock] then [0, 6]
      when [Choice::Scissors, Choice::Paper] then [6, 0]
      when [Choice::Scissors, Choice::Scissors] then [3, 3]
      end
    end

    sig { params(list_of_games: String).returns(T::Array[Game]) }
    def self.predicted_encrypted_strategy_guide(list_of_games)
      list_of_games.split("\n").map do |line|
        line.split.map do |choice|
          case choice
          when 'A', 'X' then Choice::Rock
          when 'B', 'Y' then Choice::Paper
          when 'C', 'Z' then Choice::Scissors
          else raise 'Parsing Error'
          end
        end
      end
    end

    sig { params(list_of_games: String).returns(T::Array[T.nilable(Integer)]) }
    def self.actual_total_scores(list_of_games)
      games = actual_encrypted_strategy_guide(list_of_games)
      games.map do |game|
        predicted_scores(game)
      end.transpose.map(&:sum)
    end

    sig { params(list_of_games: String).returns(T::Array[Game]) }
    def self.actual_encrypted_strategy_guide(list_of_games)
      list_of_games.split("\n").map do |line|
        player_1_choice_char, player_2_end_state_char = line.split
        player_1_choice = case player_1_choice_char
                          when 'A' then Choice::Rock
                          when 'B' then Choice::Paper
                          when 'C' then Choice::Scissors
                          else raise 'Parsing Error'
                          end
        player_2_end_state = case player_2_end_state_char
                             when 'X' then EndState::Lose
                             when 'Y' then EndState::Draw
                             when 'Z' then EndState::Win
                             else raise 'Parsing Error'
                             end
        player_2_choice = player_move_for_opponent_choice_and_end_state(player_1_choice, player_2_end_state)

        [player_1_choice, player_2_choice]
      end
    end

    sig { params(opponent_choice: Choice, end_state: EndState).returns(Choice) }
    def self.player_move_for_opponent_choice_and_end_state(opponent_choice, end_state)
      case [opponent_choice, end_state]
      when [Choice::Rock, EndState::Win] then Choice::Paper
      when [Choice::Rock, EndState::Lose] then Choice::Scissors
      when [Choice::Rock, EndState::Draw] then Choice::Rock
      when [Choice::Paper, EndState::Win] then Choice::Scissors
      when [Choice::Paper, EndState::Lose] then Choice::Rock
      when [Choice::Paper, EndState::Draw] then Choice::Paper
      when [Choice::Scissors, EndState::Win] then Choice::Rock
      when [Choice::Scissors, EndState::Lose] then Choice::Paper
      when [Choice::Scissors, EndState::Draw] then Choice::Scissors
      else raise 'GameLogic Error'
      end
    end
  end
end
