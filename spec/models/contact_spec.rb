# encoding: UTF-8
require 'spec_helper'

describe Contact do

  before do
    @contact = Contact.new(otsikko: "Viherkattotietokanta!", email: "viher@katto.fi", puhelin: "040-040040", note: "Testi", osoite: "Kumpula rock city")

  end

  subject { @contact }

  it { should respond_to (:otsikko) }
  it { should respond_to (:email) }
  it { should respond_to (:puhelin) }
  it { should respond_to (:note) }
  it { should respond_to (:osoite) }


  describe "When otsikko is of valid length" do
    before { @contact.otsikko = 'Tämä on otsikko' }
    it { should be_valid }
  end

  describe "When otsikko is too damn long" do
    before { @contact.otsikko = "teeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeessssssssssssssssssssssssssssssssssssssssssyyyyyyyyyyyyyyyyyyyyyyttttttttttttttttttttttt!" }
    it { should_not be_valid }
  end

end