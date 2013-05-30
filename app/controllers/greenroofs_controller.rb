# encoding: UTF-8

class GreenroofsController < ApplicationController
  def new
    @greenroof = Greenroof.new
    @base = Base.new
    @roof = Roof.new
    @environments = Environment.all
    @layer = Layer.new
    @base = Base.new
  end

  def create

    @greenroof = Greenroof.new( params[:@greenroof] )


    Greenroof.transaction do
      begin
        # Creates a new roof and adds environments to it
        @roof = Roof.new( params[:roof] )
        params[:environment][:id].shift
        if not !params[:environment][:id].empty?
          params[:environment][:id].each do |env|
            @env = Environment.find_by_id(env)
            if @env != nil
              @roof.environments << @env
            end
          end
        end
        # If there was no enviroments selected return to form and print error message
        if params[:environment][:id].empty?
          flash.now[:error] = "Et valinnut ympäristöä"
          render 'new'
          return
        end
        @roof.save!

        @layer = Layer.create!( params[:layer] )


      # '!' in the save and create functions rises an exception. In this case the form view is rendered and all
      # successful transactions in the block (from the save and create functions) are rolled back.
      rescue ActiveRecord::RecordInvalid
        render 'new'
        raise ActiveRecord::Rollback
      end

    end
  end
end
