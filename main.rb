class Node
  attr_accessor :data,:left_node,:right_node
  def initialize(data)
    @data = data
    @left_node = nil
    @right_node = nil
  end
end

class Trees
  def initialize(array)
    @array = array.sort
    @root = nil
  end

  def build_tree
    @root = building(@array,0,@array.length-1)
  end

  def building(array,left,right)
    return nil if left>right
    mid = (right+left)/2
    root = Node.new(array[mid])
    root.left_node = building(array,left,mid-1)
    root.right_node = building(array,mid+1,right)
    return root
  end

  def insertNode(value)
    @root = inserting(@root,value)
  end

  def inserting(root,value)
    return Node.new(value) if root.nil?
    if value>root.data
      root.right_node = inserting(root.right_node,value)
    else  
      root.left_node = inserting(root.left_node,value)
    end
    return root
  end

  def minValueNode(root)
    current = root
    while current.left_node!=nil && current!=nil
      current = current.left_node
    end
    return current
  end
  
  def deleteNode(value)
    root = deleteing(@root,value)
  end
  def deleteing(root,value)
    return root if root.nil?
    if value>root.data
      root.right_node = deleteing(root.right_node,value)
    elsif value<root.data
      root.left_node = deleteing(root.left_node,value)
    else
      if(root.left_node.nil? && root.right_node.nil?)
        return nil
      elsif root.left_node.nil?
        temp = root.right_node
        root.right_node = nil
        return temp
      elsif root.right_node.nil?
        temp = root.left_node
        root.left_node = nil
        return temp
      end
      temp = minValueNode(root.right_node)
      root.data = temp.data
      root.right_node = deleteing(root.right_node,temp.data)
    end
    return root
  end

  def find(root = @root,value)
    return root if root.nil?
    if value>root.data
      find(root.right_node,value)
    elsif value<root.data
      find(root.left_node,value)
    else
      return root
    end
  end

  def levelorder(root = @root)
    q = Array.new
    arr = Array.new
    q.push(root)
    while !q.empty?
      temp = q[0]
      q.push(temp.left_node) if temp.left_node
      q.push(temp.right_node) if temp.right_node
      arr.push(temp.data)
      q.shift
    end
    return arr
  end

  def inorder(root = @root,arr)
    return arr if root.nil?
    inorder(root.left_node,arr)
    arr.push(root.data)
    inorder(root.right_node,arr)
  end

  def preorder(root = @root,arr)
    return arr if root.nil?
    arr.push(root.data)
    preorder(root.left_node,arr)
    preorder(root.right_node,arr)
  end

  def postorder(root = @root,arr)
    return arr if root.nil?
    postorder(root.left_node,arr)
    postorder(root.right_node,arr)
    arr.push(root.data)
  end

  def max(a,b)
    if a>b   
      return a 
    else  
      return b   
    end
  end

  def height(node = @root)
    return 0 if node.nil?
    return 1 + max(height(node.left_node),height(node.right_node))
  end

  def depth(root,node)
    return -1 if root.nil?
    dist = -1
    return dist + 1 if((root == node) || (dist = depth(root.left_node,node)) >= 0 || (dist = depth(root.right_node,node)) >= 0)
    return dist
  end

  def balanced?(root = @root)
    return true if root.nil?
    lh = height(root.left_node)
    rh = height(root.right_node)
    return true if((lh-rh).abs<=1 && balanced?(root.left_node) && balanced?(root.right_node))
    return false
  end

  def rebalance(root = @root)
    array = Array.new
    inorder(root,array)
    @array = array
    build_tree
  end
end

arr = Array.new(15){rand 1..100}
tree = Trees.new(arr)
tree.build_tree
puts tree.balanced?
p tree.levelorder
p tree.inorder(Array.new)
p tree.postorder(Array.new)
p tree.preorder(Array.new)
for i in 1..105
  tree.insertNode(rand 1..200)
end
puts tree.balanced?
tree.rebalance
puts tree.balanced?
p tree.levelorder
p tree.inorder(Array.new)
p tree.postorder(Array.new)
p tree.preorder(Array.new)
