require 'spec_helper'

describe Image do

  before { @image = Image.new(photo: "lalala", thumb: "thumb_lalala") }

  subject { @image }

  it { should respond_to :photo }
  it { should respond_to :thumb }

  describe "with too long photo name" do
    before { @image.photo = "a" * 101 }
    it { should_not be_valid }
  end

  describe "with too long thumb name" do
    before { @image.thumb = "a" * 101 }
    it { should_not be_valid }
  end

  describe "with valid photo name" do
    before { @image.photo = "this_is_fine" }
    it { should be_valid }
  end

  describe "with valid thumb name" do
    before { @image.thumb = "this_is_fine"  }
    it { should be_valid }
  end

  describe "without photo name" do
    before { @image.photo = ""  }
    it { should be_valid }
  end

  describe "without thumb name" do
    before { @image.thumb = ""  }
    it { should be_valid }
  end
end
