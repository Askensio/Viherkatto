# encoding: UTF-8

# Helper methods for plants

module PlantsHelper

  def listSelectedEnvironments (environments)
    envs = []
    environments.each do |env|
      envs << env.id
    end
    return envs
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

  #def colour_categories
  #  I18n.t(:colour_categories).map { |key, value| [value, key.to_s] }
  #end
end
