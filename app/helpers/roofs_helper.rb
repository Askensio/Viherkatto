# encoding: UTF-8

module RoofsHelper
  def environments
    @environments = []
    @all = Environment.all
    @all.each do |environment|
      @environments.append(environment.name)
    end
    return @environments
  end
end
