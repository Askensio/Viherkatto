# encoding: UTF-8

require 'spec_helper'

describe Base do
  before do
    @base = Base.new(absorbancy: 100, note: "jejee")
  end

  subject { @base }

  it { should respond_to(:absorbancy) }
  it { should respond_to(:note) }

  it { should be_valid }

  describe "when absorbancy is not present" do
    before { @base.absorbancy="" }
    it { should be_valid }
  end

  describe "absorbancy isn't numerical" do
    before { @base.absorbancy="jee" }
    it { should_not be_valid }
  end

  describe "absorbancy is negative" do
    before { @base.absorbancy=-1 }
    it { should_not be_valid }
  end

  describe "note is too long" do
    before { @base.note = "a"*1600 }
    it { should_not be_valid }
  end

end
