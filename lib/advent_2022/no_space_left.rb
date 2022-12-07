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
      parent = nodes_by_id[node.parent_id]
      if parent && !node.is_root
        id(node: parent, nodes_by_id: nodes_by_id) + node.name
      elsif node.is_root
        node.name
      else
        raise 'invalid id construction'
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
      nodes_by_id[directory.parent_id]
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


    sig { params(terminal_output: String).returns(String) }
    def self.visual_output(terminal_output)
      current_directory = nil
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
            current_directory = parent(directory: current_directory, nodes_by_id: nodes_by_id)
          else
            current_directory = children(directory: current_directory, nodes_by_id: nodes_by_id).find do |child|
              child.name == arg
            end
          end
        when 'ls'
          parent_id = id(node: current_directory, nodes_by_id: nodes_by_id)
          children = outputs.map do |output|
            first_item, second_item = output.split(' ')
            case first_item
            when 'dir'
              node = Node.new(name: second_item, node_type: NodeType::Dir, parent_id: parent_id, is_root: false)
            else
              node = Node.new(name: second_item, node_type: NodeType::File, parent_id: parent_id, size: first_item.to_i, is_root: false)
            end
            nodes_by_id[id(node: node, nodes_by_id: nodes_by_id)] = node

            node
          end

          children_ids = children.map do |child|
            id(node: child, nodes_by_id: nodes_by_id)
          end
          new_props = current_directory.serialize.merge("children_ids" => children_ids)
          current_directory = Node.from_hash(new_props)
          nodes_by_id[id(node: current_directory, nodes_by_id: nodes_by_id)] = current_directory
        end
      end

      root = nodes_by_id['/']
      stringify(node: root, nodes_by_id: nodes_by_id, generation: 0)
    end
  end
end