require 'spec_helper'

describe Alephant::Logger do
  describe ".get_logger" do

    context "no logger set" do
      it "returns standard Logger" do
        expect(subject.get_logger).to be_a Logger
      end
    end

    context "subject.set_logger(:foo)" do
      it "returns @@logger" do
        subject.class_variable_set(:@@logger, :foo)
        expect(subject.get_logger).to eq(:foo)
      end
    end
  end

  describe ".set_logger(:foo)" do
    it "sets foo as @@logger" do
      subject.set_logger(:bar)
      expect(subject.class_variable_get(:@@logger)).to eq(:bar)
    end
  end

  context "when included in a class" do

    class IncludesLog
      include Alephant::Logger

      def calls_logger
        logger
      end
    end

    context "called via '#logger'" do
      it "returns the value of @@logger" do
        subject.class_variable_set(:@@logger, :baz)
        expect(IncludesLog.new.calls_logger).to eq(:baz)
      end
    end

  end
end
