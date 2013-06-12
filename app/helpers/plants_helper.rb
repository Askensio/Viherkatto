# encoding: UTF-8

module PlantsHelper

  def coverageLevel(index)
    @coverage = %w( Pieni Keskisuuri Suuri )

    @level = @coverage[index]
  end

  def lightness(index)
    @lightness = %w( Aurinkoinen Varjoinen Puolivarjo )

    @light = @lightness[index]
  end

  def maintenanceLevel(index)
    @maintenance = %w( Helppo Keskivaikea Vaikea )

    @level = @maintenance[index]
  end

  def printEnvironments (environments)
    envs = ""
    counter = 1
    environments.each do |env|
      if (counter != 1)
        envs += ", "
      end
      envs += env.environment
      counter += 1
    end
    return envs
  end

  def colours
    %w( Blue Red Green Yellow White)
  end

  def colour_categories
    I18n.t(:colour_categories).map { |key, value| [value, key.to_s] }
  end
end
