require "spec_helper"

require "pry"
describe Alephant::Logger::Base do
  context "no Alephant::Logger::JSON driver given" do
    it "defaults to include Alephant::Logger::JSON" do
      allow(Alephant::Logger::JSON).to receive(:new) { @called = true }

      described_class.new []
      expect(@called).to be_truthy
    end
  end

  describe "#info" do
    context "no logger drivers given" do
      subject { Alephant::Logger::Base.new [] }

      specify do
        expect_any_instance_of(Alephant::Logger::JSON).to receive(:info).with("event" => "Evented")

        subject.info("event" => "Evented")
      end
    end

    context "logger drivers given" do
      subject { Alephant::Logger::Base.new [driver] }

      let(:driver) { double }

      it "responding drivers receive method calls" do
        expect(driver).to receive(:metric).with("foo")

        subject.metric("foo")
      end

      it "Alephant::Logger::JSON is always used" do
        expect_any_instance_of(Alephant::Logger::JSON).to receive(:info).with("event" => "Evented")

        subject.info("event" => "Evented")
      end
    end
  end
end
