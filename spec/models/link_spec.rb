require 'spec_helper'

describe Link do

  before do
    @link = Link.new(name: "Cobun kotikokkisivut", link: "http://lol.in")
  end

  subject { @link }

  it { should respond_to(:name) }
  it { should respond_to(:link) }

  it { should be_valid }

  #describe 'when name is not present' do
  #  before { @link.name = " " }
  #  it { should_not be_valid }
  #end

  describe 'when name is too long' do
    before { @link.name = "a"*101 }
    it { should_not be_valid }
  end

  describe 'when name is correct' do
    before { @link.name = "Cobun kotikokkisivut" }
    it { should be_valid }
  end

  #describe 'when link is not present' do
  #  before { @link.link = " " }
  #  it { should_not be_valid }
  #end

  describe 'when link is too long' do
    before { @link.link = "a"*101 }
    it { should_not be_valid }
  end

  describe 'when link is correct' do
    before { @link.link = "http://lol.in" }
    it { should be_valid }
  end
end
