# typed: strict

module Advent2022
  module NoSpaceLeft
    extend T::Sig

    class NodeType < T::Enum
      enums do
        File = new
        Dir = new
      end
    end

    class Command < T::Enum
      enums do
        CD = new
        LS = new
      end
    end

    class Node < T::Struct
      prop :parent_id, T.nilable(String)
      prop :name, String
      prop :node_type, NodeType
      prop :size, T.nilable(Integer)
      prop :children_ids, T.nilable(T::Array[String])
      prop :is_root, T::Boolean
    end

    sig { params(node: Node, nodes_by_id: T::Hash[String, Node]).returns(String) }
    def self.id(node:, nodes_by_id:)
      parent = nodes_by_id[T.must(node.parent_id)]
      if parent && !node.is_root
        if parent.is_root
          '/' + node.name
        else
          id(node: parent, nodes_by_id: nodes_by_id) + '/' + node.name
        end
      elsif node.is_root
        node.name
      else
        raise 'invalid id construction'
      end
    end

    sig { params(node: Node, nodes_by_id: T::Hash[String, Node]).returns(Integer) }
    def self.size(node:, nodes_by_id:)
      case node.node_type
      when NodeType::Dir
        children(directory: node, nodes_by_id: nodes_by_id).sum do |child|
          size(node: child, nodes_by_id: nodes_by_id)
        end
      when NodeType::File
        node.size
      end
    end

    sig { params(directory: Node, nodes_by_id: T::Hash[String, Node]).returns(T::Array[Node]) }
    def self.children(directory:, nodes_by_id:)
      (directory.children_ids || []).map do |child_id|
        nodes_by_id[child_id]
      end
    end

    sig { params(directory: Node, nodes_by_id: T::Hash[String, Node]).returns(Node) }
    def self.parent(directory:, nodes_by_id:)
      T.must(nodes_by_id[T.must(directory.parent_id)])
    end

    sig { params(node: Node, nodes_by_id: T::Hash[String, Node], generation: Integer).returns(String) }
    def self.stringify(node:, nodes_by_id:, generation:)
      indententation = '  ' * generation
      node_string = case node.node_type
                    when NodeType::Dir
                      "#{indententation}- #{node.name} (dir)"
                    when NodeType::File
                      "#{indententation}- #{node.name} (file, size=#{node.size})"
                    end
      children_strings = children(directory: node, nodes_by_id: nodes_by_id).map do |child|
        stringify(node: child, nodes_by_id: nodes_by_id, generation: generation + 1)
      end
      children_strings.unshift(node_string).join("\n")
    end

    sig { params(nodes_by_id: T::Hash[String, Node]).returns(Integer) }
    def self.solution(nodes_by_id:)
      nodes_by_id.values.select do |node|
        node.node_type == NodeType::Dir
      end.map do |directory|
        size(node: directory, nodes_by_id: nodes_by_id)
      end.select do |dir_size|
        dir_size <= 100_000
      end.sum
    end

    sig { params(nodes_by_id: T::Hash[String, Node], total_disk_space: Integer, required_disk_space: Integer).returns(Integer) }
    def self.solution_2(nodes_by_id:, total_disk_space: 70_000_000, required_disk_space: 30_000_000)
      used_disk_space = size(node: T.must(nodes_by_id['/']), nodes_by_id: nodes_by_id)
      free_disk_space = total_disk_space - used_disk_space
      need_disk_space = required_disk_space - free_disk_space

      T.must(nodes_by_id.values.select do |node|
        node.node_type == NodeType::Dir
      end.map do |directory|
        size(node: directory, nodes_by_id: nodes_by_id)
      end.select do |dir_size|
        need_disk_space <= dir_size
      end.min)
    end

    sig { params(terminal_output: String).returns([Node, T::Hash[String, Node]]) }
    def self.data_structure(terminal_output:)
      current_directory = T.let(nil, T.nilable(Advent2022::NoSpaceLeft::Node))
      nodes_by_id = {}

      commands_and_ouputs = terminal_output.split('$ ')
      commands_and_ouputs.each do |cao|
        command, *outputs = cao.split("\n")
        next if command.nil? || command.empty?
        command_program, arg = command.split(' ')
        case command_program
        when 'cd'
          case arg
          when '/'
            current_directory = Node.new(name: '/', node_type: NodeType::Dir, is_root: true)
            id = id(node: current_directory, nodes_by_id: nodes_by_id)
            nodes_by_id[id] = current_directory
            current_directory
          when '..'
            current_directory = parent(directory: T.must(current_directory), nodes_by_id: nodes_by_id)
          else
            current_directory = children(directory: T.must(current_directory), nodes_by_id: nodes_by_id).find do |child|
              child.name == arg
            end
          end
        when 'ls'
          parent_id = id(node: T.must(current_directory), nodes_by_id: nodes_by_id)
          children = T.must(outputs).map do |output|
            first_item, second_item = output.split(' ')
            case first_item
            when 'dir'
              node = Node.new(name: T.must(second_item), node_type: NodeType::Dir, parent_id: parent_id, is_root: false)
            else
              node = Node.new(name: T.must(second_item), node_type: NodeType::File, parent_id: parent_id, size: first_item.to_i, is_root: false)
            end
            nodes_by_id[id(node: node, nodes_by_id: nodes_by_id)] = node

            node
          end

          children_ids = children.map do |child|
            id(node: child, nodes_by_id: nodes_by_id)
          end
          new_props = T.must(current_directory).serialize.merge('children_ids' => children_ids)
          current_directory = Node.from_hash(new_props)
          nodes_by_id[id(node: current_directory, nodes_by_id: nodes_by_id)] = current_directory
        end
      end
      root = nodes_by_id['/']
      [root, nodes_by_id]
    end
  end
end
