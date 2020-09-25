require "admiral"
require "colorize"
require "log"

require "./format"
require "./graph"

module Decompose
  VERSION = "0.1.0"

  class Application < Admiral::Command
    define_version Decompose::VERSION
    define_help description: "Decompose"

    define_flag config : String,
      description: "",
      default: "docker-compose.yaml",
      short: c

    def run
      unless File.exists?(flags.config)
        raise "File \"#{flags.config}\" does not exist!"
      end

      content = File.read(flags.config)
      config = Decompose::Format::Configuration.from_yaml(content)

      graph = Decompose::DirectedGraph.new
      config.services.each do |name, service|
        graph.add_vertex(name)
        service.get_dependencies.each do |dependency|
          graph.add_edge(name, dependency)
        end
      end

      puts graph.to_dot
    rescue ex : Exception
      puts ex.message.colorize(:red)
    end
  end
end

Decompose::Application.run
