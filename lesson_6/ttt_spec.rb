require_relative "ttt"
require "pry"

RSpec.describe "tic_tac_toe" do
  describe "#welcome_message" do
    it "prints the welcome message" do
      allow(Kernel).to receive(:puts)

      welcome_message

      expect(Kernel).to have_received(:puts).with("Welcome to Tic Tac Toe!")
      expect(Kernel).to have_received(:puts).with("The first one to score 5 will be the grand winner!")
    end
  end

  describe "#computer_offense" do
    context "when player and computer are both 1 move away from winning" do
      it "chooses the winning move" do
        board = {}
        (1..9).each { |num| board[num] = " " }
        board[1] = "O"
        board[3] = "X"
        board[4] = "O"
        board[6] = "X"

        new_board = computer_offense(board)
        expected_board = board.clone
        expected_board[7] = "O"

        expect(new_board).to eq(expected_board)
      end
    end
  end

  describe "#computer_defense" do
    context "when player is about to win" do
      it "blocks the player" do
        board = {}
        (1..9).each { |num| board[num] = " " }
        board[1] = "X"
        board[3] = "O"
        board[4] = "X"

        new_board = computer_defense(board)
        expected_board = board.clone
        expected_board[7] = "O"

        expect(new_board).to eq(expected_board)
      end
    end
  end

  describe "#computer_random" do
    context "if square 5 is empty" do
      it "pick square 5" do
        board = {}
        (1..9).each { |num| board[num] = " " }

        new_board = computer_pick_five(board)
        expected_board = board.clone
        expected_board[5] = "O"

        expect(new_board).to eq(expected_board)
      end
    end
  end

  describe "#display_board" do
    context "after each player's turn" do
      it "prints the game board" do
        board = {}
        (1..9).each { |num| board[num] = " " }

        allow(Kernel).to receive(:system)
        allow(Kernel).to receive(:puts)

        display_board(board)
        expect(Kernel).to have_received(:puts).with([
          "You're a #{PLAYER_MARKER}. Computer is #{COMPUTER_MARKER}.",
          "",
          "     |     |",
          "  #{board[1]}  |  #{board[2]}  |  #{board[3]}",
          "     |     |",
          "-----+-----+-----",
          "     |     |",
          "  #{board[4]}  |  #{board[5]}  |  #{board[6]}",
          "     |     |",
          "-----+-----+-----",
          "     |     |",
          "  #{board[7]}  |  #{board[8]}  |  #{board[9]}",
          "     |     |",
          ""
        ].join("\n"))
      end
    end
  end

  describe "#player_chooses" do
    it "returns a board with the player choice" do
      board = {}
      (1..9).each { |num| board[num] = " " }

      new_board = player_chooses(board, 3)

      expected_board = board.clone
      expected_board[3] = "X"

      expect(new_board).to eq(expected_board)
    end

    context "when a position is taken" do
      it "prints invalid message and asks to choose again" do
        board = {}
        (1..9).each { |num| board[num] = " " }
        board[1] = COMPUTER_MARKER

        allow(Kernel).to receive(:puts)

        new_board = player_chooses(board, 1)
        expected_board = board.clone

        expect(Kernel).to have_received(:puts).with("Invalid choice")
        expect(new_board).to eq(expected_board)
      end
    end
  end
end