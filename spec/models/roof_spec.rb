# encoding: UTF-8

require 'spec_helper'

describe Roof do
  before do


    Light.create!(value: "Varjoisa")
    Light.create!(value: "Puolivarjoisa")
    Light.create!(value: "Aurinkoinen")

    @roof = Roof.new(area: 50, declination: 1, load_capacity: 480)
    @roof.update_attribute(:light_id, 2)
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

  describe 'when area is not a number' do
    before { @roof.area = "yolo swaggings" }
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

  describe 'when declination is too hight' do
    before { @roof.declination = 3}
    it { should_not be_valid }
  end

  describe 'when declination is not a number' do
    before { @roof.declination = "yolo swaggings" }
    it { should_not be_valid }
  end

  describe 'when declination is present and valid' do
    before { @roof.declination = 1 }
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

  describe 'when load capacity is not a number' do
    before { @roof.load_capacity = "yolo swaggings" }
    it { should_not be_valid }
  end

  describe 'when load capacity is present and valid' do
    before { @roof.load_capacity = 500 }
    it { should be_valid }
  end
end
