require 'spec_helper'

describe Alephant::Logger do
  describe ".create" do
    specify do
      expect(subject.create).to be_a Alephant::Logger::Logger
    end
  end
end

describe Alephant::Logger::Logger do
  describe "#info" do
    context "no logger drivers given" do
      subject { Alephant::Logger::Logger.new [] }

      specify do
        expect_any_instance_of(::Logger).to receive(:info).with "msg"

        subject.info "msg"
      end
    end

    context "logger drivers given" do
      subject { Alephant::Logger::Logger.new [driver] }

      let(:driver) { double }

      it "responding drivers receive method calls" do
        expect(driver).to receive(:metric).with("foo")

        subject.metric("foo")
      end

      it "::Logger is always used" do
        expect_any_instance_of(::Logger).to receive(:info).with "foo"

        subject.info "foo"
      end
    end
  end
end
