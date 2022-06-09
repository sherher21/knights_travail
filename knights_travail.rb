class MoveTree
  attr_reader :position, :parent
  @@history = []
  @@row_move = [2, 2, -2, -2, 1, 1, -1, -1]
  @@col_move  = [-1, 1, 1, -1, 2,-2, 2, -2]

  def initialize(position, parent)
    @position = position
    @parent = parent
    @@history << position
  end

  def possible_moves(pos)
    move_list = []
    for i in 0..7
      rank = @@row_move[i] + pos[0] 
      file = @@col_move[i] + pos[1]
      move_list << [rank, file] if rank.between?(0,7) && file.between?(0,7)
    end
    move_list
  end

  def children
    return possible_moves(@position).reject { |pos| @@history.include?(pos) }
                                    .map! { |posit| MoveTree.new(posit, self)}
  end
end

def shortest_path(node, list = [])
  shortest_path(node.parent, list) unless node.parent.nil?
  list << node.position
end

def knight_moves(start_position, end_position, queue = [])
  node = MoveTree.new(start_position, nil)
  until node.position == end_position
    node.children.each { |child| queue << child }
    node = queue.shift
  end
  shortest_path(node)
end

p knight_moves([0,0],[7,7])
