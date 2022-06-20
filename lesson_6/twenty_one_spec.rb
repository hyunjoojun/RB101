# frozen_string_literal: true

require "pry"

require_relative "twenty_one_game"

RSpec.describe "TwentyOne game" do
  describe "#hit!" do
    it "updates cards and count" do
      state = round_state
      person = "player"
      state[:player_cards] = []
      state[:player_count] = 0

      allow(state[:deck]).to receive(:pop).and_return(["♥", :"8"])
      hit!(state, person)

      expect(state[:player_cards]).to eq([["♥", :"8"]])
      expect(state[:player_count]).to eq(8)
    end

    context "when there is an Ace" do
      it "subtract 10 from total if total > 21" do
      state = round_state
      person = "player"
      state[:player_cards] = [["♦", :Ace], ["♠", :"6"]]
      state[:player_count] = 17

      allow(state[:deck]).to receive(:pop).and_return(["♥", :"8"])
      hit!(state, person)

      expect(state[:player_cards]).to eq([["♦", :Ace], ["♠", :"6"], ["♥", :"8"]])
      expect(state[:player_count]).to eq(15)
      end
    end

    context "when there is an Ace" do
      it "subtract 10 from total if total > 21" do
      state = round_state
      person = "player"
      state[:player_cards] = [["♦", :Ace], ["♠", :"5"], ["♠", :"10"]]
      state[:player_count] = 16

      allow(state[:deck]).to receive(:pop).and_return(["♥", :"Queen"])
      hit!(state, person)

      expect(state[:player_cards]).to eq([["♦", :Ace], ["♠", :"5"], ["♠", :"10"], ["♥", :"Queen"]])
      expect(state[:player_count]).to eq(26)
      end
    end
  end
end
