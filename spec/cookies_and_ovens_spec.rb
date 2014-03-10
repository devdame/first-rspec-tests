require_relative '../cookies_and_ovens'
require 'rspec'

describe Baker do
  let(:baker) { Baker.new}

  context "#initialize" do
    it "creates a Baker object" do
      baker.should be_an_instance_of Baker
    end
  end

  context "#turn_on_oven" do
    before do
      baker.turn_on_oven
    end
    it "should assign a new Oven object as its oven if it doesn't already have one" do
      expect(baker.oven).to be_an_instance_of Oven
    end

    it "should change the baker's oven_on attribute to true" do
      expect(baker.oven.oven_on).to be_true
    end
  end

  context "#make_cookie_batch" do
    before do
      baker.make_cookie_batch(:Snickerdoodle)
    end

    let(:batch) { baker.batch }

    it "makes cookies" do
      expect(batch.first).to be_kind_of Cookie
    end
    it "should make thirteen new cookies" do
      expect(batch.length).to eq 13
    end
  end

end
