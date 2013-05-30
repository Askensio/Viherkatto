# encoding: UTF-8

require 'spec_helper'

describe Base do
  before do
    @base = Base.new(absorbancy: 100)
  end

  subject { @base }

  it { should respond_to(:absorbancy) }

  it { should be_valid }

  describe "when absorbancy is not present" do
    before { @base.absorbancy="" }
    it { should_not be_valid }
  end

  describe "absorbancy isn't numerical" do
    before { @base.absorbancy="jee" }
    it { should_not be_valid }
  end

end
