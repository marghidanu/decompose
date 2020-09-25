require "yaml"

module Decompose::Format
  class Configuration
    include YAML::Serializable

    property version : String
    property services : Hash(String, Decompose::Format::Service)
  end

  class Service
    include YAML::Serializable

    property depends_on : Array(String) | Hash(String, Decompose::Format::Dependency) | Nil

    def get_dependencies : Array(String)?
      result = Array(String).new

      case @depends_on
      when Array(String)
        @depends_on.as(Array(String)).each do |value|
          result << value
        end
      when Hash(String, Decompose::Format::Dependency)
        @depends_on.as(Hash(String, Decompose::Format::Dependency)).each_key do |key|
          result << key
        end
      else
      end

      result
    end
  end

  class Dependency
    include YAML::Serializable

    property condition : String
  end
end
