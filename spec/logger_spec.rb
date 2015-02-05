require 'spec_helper'

describe Alephant::Logger do
  describe ".setup" do
    specify do
      expect(subject.setup).to be_a Alephant::Logger::Base
    end
  end
end
