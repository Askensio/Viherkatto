#encoding: utf-8

require 'spec_helper'

describe Purpose do
  before { @purpose = Purpose.new(value: "Käyttökatto") }

  subject { @purpose }

  it { should respond_to :value }

end
