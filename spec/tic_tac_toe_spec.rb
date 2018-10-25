require './ttt/player.rb'

describe "Player" do
  describe "Test" do
    it "Test 2" do
        expect(Player.new("one", "two").name).to eq("one")
        expect(Player.new("one", "two").token).to eq("two")
    end
  end
end