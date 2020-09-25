module Decompose
  class DirectedGraph
    def initialize
      @adjacency_list = Hash(String, Set(String)).new
    end

    def add_vertex(name : String)
      unless @adjacency_list.has_key?(name)
        @adjacency_list[name] = Set(String).new
      end
    end

    def add_edge(from : String, to : String)
      add_vertex(from)
      add_vertex(to)

      @adjacency_list[from].add(to)
    end

    def to_dot
      builder = String::Builder.new

      builder.puts "digraph G {"
      builder.puts "\trankdir=LR;"
      builder.puts "\tnode [shape=record];"
      @adjacency_list.each do |name, dependencies|
        builder.puts "\t\"#{name}\";"
        dependencies.each do |dependency|
          builder.puts "\t\"#{name}\" -> \"#{dependency}\";"
        end
      end
      builder.puts "}"

      builder.to_s
    end
  end
end
