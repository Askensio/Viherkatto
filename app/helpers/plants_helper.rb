# encoding: UTF-8

module PlantsHelper

  def lightness
    @lightness = %w( a b c )
  end

  def colours
    %w( Blue Red Green Yellow White)
  end

  def colour_categories
    I18n.t(:colour_categories).map { |key, value| [ value, key.to_s ] }
  end
end
