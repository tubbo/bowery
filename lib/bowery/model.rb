module Bowery
  module Model
    def initialize params={}
      params.each { |k,v| send "#{k}=", v } unless params.empty?
      @attributes = params
      super
    end
  end
end
