# encoding: UTF-8

require 'spec_helper'

describe Roof do
  before do
    @roof = Roof.new(area: 50, declination: 10, load_capacity: 480)
  end

  subject { @roof }

  it { should respond_to(:area) }
  it { should respond_to(:declination) }
  it { should respond_to(:load_capacity)}

  it { should be_valid }

  describe 'when area is not present' do
    before { @roof.area = " " }
    it { should_not be_valid }
  end

  describe 'when area is negative' do
    before { @roof.area = -50 }
    it { should_not be_valid }
  end

  describe 'when area is present and valid' do
    before { @roof.area = 50 }
    it { should be_valid }
  end

  describe 'when declination is not present' do
    before { @roof.declination = " " }
    it { should_not be_valid }
  end

  describe 'when declination is negative' do
    before { @roof.declination = -50 }
    it { should_not be_valid }
  end

  describe 'when declination is present and valid' do
    before { @roof.declination = 50 }
    it { should be_valid }
  end

  describe 'when load capacity is not present' do
    before { @roof.load_capacity = " " }
    it { should_not be_valid }
  end

  describe 'when load capacity is negative' do
    before { @roof.load_capacity = -500 }
    it { should_not be_valid }
  end

  describe 'when load capacity is present and valid' do
    before { @roof.load_capacity = 500 }
    it { should be_valid }
  end

  describe "when roof with same specs already exists" do
    before do
      @roof.save
      @roof_with_same_specs = @roof.dup
    end
    it 'should not allow to save an other with same specs' do
      expect { @roof_with_same_specs.save }.to raise_error
    end
  end
end
