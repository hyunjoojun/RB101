require_relative "rps_bonus"
require "pry"

RSpec.describe "RPSBonus" do
  describe "#valid_choice" do
    it "returns false when a choice is invalid" do
      valid = valid_choice?("car")

      expect(valid).to eq(false)
    end

    it "returns true when a choice is valid" do
      valid = valid_choice?("rock")

      expect(valid).to eq(true)
    end
  end

  describe "#calculate_winner" do
    it "foo" do
      winner = calculate_winner('rock', 'scissors')

      expect(winner).to eq('rock')
    end

    it "foo" do
      winner = calculate_winner('rock', 'paper')

      expect(winner).to eq('paper')
    end
  end
end