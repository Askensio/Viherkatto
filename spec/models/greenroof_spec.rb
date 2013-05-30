# encoding: UTF-8
require 'spec_helper'

describe Greenroof do
  before do
    @groof = Greenroof.new(address: "Kumpulan kampus", purpose: 0, note: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper suscipit lobortis nisl ut aliquip ex ea commodo consequat. Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi. Nam liber tempor cum soluta nobis eleifend option congue nihil imperdiet doming id quod mazim placerat facer possim assum. Typi non habent claritatem insitam; est usus legentis in iis qui facit eorum claritatem. Investigationes demonstraverunt lectores legere me lius quod ii legunt saepius. Claritas est etiam processus dynamicus, qui sequitur mutationem consuetudium lectorum. Mirum est notare quam littera gothica, quam nunc putamus parum claram, anteposuerit litterarum formas humanitatis per seacula quarta decima et quinta decima. Eodem modo typi, qui nunc nobis videntur parum clari, fiant sollemnes in futurum.")

    @base = Base.new(absorbancy: 20)
    @layer1 = Layer.new(name: "Materiaali1", thickness: 30, weight: 20)
    @layer2 = Layer.new(name: "Materiaali2", thickness: 80, weight: 10)
    @base.layers << @layer1
    @base.layers << @layer2
    @groof.bases << @base

    @roof = Roof.new(declination: 89, load_capacity: 20000, area: 500)
    @light = Light.find_by_id(1)
    @roof.light = @light
    @roof.greenroof = @groof

    @plant1 = Plant.new(name: "nättikukka", latin_name: "Kukkaus kauneus", colour: "Blue", coverage: 1, maintenance: 1,  min_soil_thickness: 20, weight: 1, note: "Oikein tosi nätti!")
    @plant2 = Plant.new(name: "Example Plant nro 2", latin_name: "Plantus Examplus Secondus", coverage: 1, colour: "Green", maintenance: 2, min_soil_thickness: 20, weight: 1, note: "This one's also a totally fabulous plant!")
    @groof.plants << @plant1
    @groof.plants << @plant2

  end

  subject { @groof }

  it { should respond_to(:address) }
  it { should respond_to(:purpose) }
  it { should respond_to(:note) }

  it { should be_valid }

end