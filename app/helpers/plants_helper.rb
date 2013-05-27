# encoding: UTF-8

module PlantsHelper

  def coverageLevel(index)
    @coverage = %w( Pieni Keskisuuri Suuri )

    @level = @coverage[index]
  end

  def lightness(index)
    @lightness = %w( Varjoinen Puolivarjo Aurinkoinen )

    @light = @lightness[index]
  end

  def maintenanceLevel(index)
    @maintenance = %w( Helppo Keskivaikea Vaikea )

    @level = @maintenance[index]
  end

  def colours
    %w( Blue Red Green Yellow White)
  end

  def colour_categories
    I18n.t(:colour_categories).map { |key, value| [ value, key.to_s ] }
  end
end
