# frozen_string_literal: true

require "pry"

require_relative "twenty_one"

RSpec.describe "TwentyOne game" do
  describe "#total" do
    it "adds cards to the total" do
      cards = [["♥", :"8"], ["♣", :King]]
      calculated_total = total(cards)

      expect(calculated_total).to eq(18)
    end

    context "when there are two Aces" do
      it "subtract 10 from total" do
        cards = [["♥", :Ace], ["♣", :Ace]]
        calculated_total = total(cards)

        expect(calculated_total).to eq(12)
      end
    end
  end
end

RSpec.describe "TwentyOne game" do
  describe "#add_to_total" do
    it "updates total" do
      initial_cards = [["♥", :"8"], ["♣", :King]]
      total = total(initial_cards)
      new_cards = [["♥", :"8"], ["♣", :King], ["♦", :"2"]]
      updated_total = add_to_total(new_cards, total)

      expect(updated_total).to eq(20)
    end

    context "when there is an Ace" do
      it "subtract 10 from total if total > 21" do
      initial_cards = [["♥", :Ace], ["♣", :"6"]]
      total = total(initial_cards)
      new_cards = [["♥", :Ace], ["♣", :"6"], ["♦", :"10"]]
      updated_total = add_to_total(new_cards, total)

      expect(updated_total).to eq(17)
      end
    end
  end
end

# RSpec.describe "TwentyOne game" do
#   describe "#update_count" do
#     it "adds a card to the count" do
#       state = round_state
#       state[:player_cards] << ["♠", "Ace"] << ["♠", "7"]

#       count = total(state[:player_cards])

#       expect(count).to eq(18)
#     end

#     context "when there is an A" do
#     end
#   end
# end