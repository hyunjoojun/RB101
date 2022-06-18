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
  end

  describe "#update_total" do
    it "updates total" do
      initial_cards = [["♥", :"8"], ["♣", :King]]
      total = total(initial_cards)
      new_cards = [["♥", :"8"], ["♣", :King], ["♦", :"2"]]
      updated_total = update_total(new_cards, total)

      expect(updated_total).to eq(20)
    end

    context "when there is an Ace" do
      it "subtract 10 from total if total > 21" do
        initial_cards = [["♥", :Ace], ["♣", :"6"]]
        total = total(initial_cards)
        new_cards = [["♥", :Ace], ["♣", :"6"], ["♦", :"10"]]
        updated_total = update_total(new_cards, total)

        expect(updated_total).to eq(17)
      end
    end
  end
end
