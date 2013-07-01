# encoding: UTF-8

# Helper methods for plants

module PlantsHelper

  # Helper function to list all environment id's
  def listSelectedEnvironments (environments)
    envs = []
    environments.each do |env|
      envs << env.id
    end
    return envs
  end

  # Helper function to list all environments
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
end
