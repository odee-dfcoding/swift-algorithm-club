  public class BinaryTree<T> {
    var value: T?
    public var leftBinaryTree: BinaryTree?
    public var rightBinaryTree: BinaryTree?
    private var parent: BinaryTree?
    
    init(_ value: T) {
      self.value = value
      
      self.leftBinaryTree = nil
      self.rightBinaryTree = nil
      self.parent = nil
    }
  }
  
  extension BinaryTree {
    var count: Int {
      guard self.value != nil else { return 0 }
      return 1 + (self.leftBinaryTree?.count ?? 0) + (self.rightBinaryTree?.count ?? 0)
    }
  }
  
  extension BinaryTree {
    func add(_ value: T) {
      // First, check if the tree is empty, assign to root if it is
      if self.value == nil {
        self.value
      } else {
        let leftBinaryTreeIsNil = self.leftBinaryTree == nil
        let rightBinaryTreeIsNil = self.rightBinaryTree == nil
        
        if leftBinaryTreeIsNil {
          self.leftBinaryTree = BinaryTree(value)
          self.leftBinaryTree!.parent = self
        } else if !leftBinaryTreeIsNil && rightBinaryTreeIsNil {
          self.rightBinaryTree = BinaryTree(value)
          self.rightBinaryTree!.parent = self
        } else if !leftBinaryTreeIsNil && !rightBinaryTreeIsNil {
          if self.leftBinaryTree!.count < self.rightBinaryTree!.count {
            self.leftBinaryTree!.add(value)
          } else {
            self.rightBinaryTree!.add(value)
          }
        }
      }
    }
  }
  
  
  
  extension BinaryTree {
    func removeLeaf() -> BinaryTree? {
      guard self.value != nil else { return nil }
      
      if let leftChild = self.leftBinaryTree {
        return leftChild.removeLeaf()
      }
      
      if let rightChild = self.rightBinaryTree {
        return rightChild.removeLeaf()
      }
      
      if let parent = self.parent {
        if parent.leftBinaryTree != nil && parent.leftBinaryTree! === self {
          parent.leftBinaryTree = nil
        } else {
          parent.rightBinaryTree = nil
        }
      }
      
      return self
    }
    
    func addTree(_ newTreeNodes: BinaryTree) {
      while newTreeNodes.count > 0 {
        self.add(newTreeNodes.removeLeaf()!.value!)
      }
    }
  }
  
  extension BinaryTree: Equatable where T: Equatable {
    public static func ==(lhs: BinaryTree<T>, rhs: BinaryTree<T>) -> Bool {
      return lhs.value == rhs.value
    }
  }
  extension BinaryTree where T: Equatable {
    public func inOrderSearch(for value: T) -> BinaryTree? {
      guard self.value != nil else { return nil }
      
      if let leftChild = self.leftBinaryTree {
        if let nodeFound = leftChild.inOrderSearch(for: value) {
          return nodeFound
        }
      }
      
      print("Checking \(self.value!)")
      
      if self.value! == value {
        return self
      }
      
      if let rightChild = self.rightBinaryTree {
        if let nodeFound = rightChild.inOrderSearch(for: value) {
          return nodeFound
        }
      }
      
      return nil
    }
    
    func preOrderSearch(for value: T) -> BinaryTree? {
      guard self.value != nil else { return nil }
      
      print("Checking \(self.value!)")
      
      if self.value! == value {
        return self
      }
      
      if let leftChild = self.leftBinaryTree {
        if let foundNode = leftChild.preOrderSearch(for: value) {
          return foundNode
        }
      }
      
      if let rightChild = self.rightBinaryTree {
        if let foundNode = rightChild.preOrderSearch(for: value) {
          return foundNode
        }
      }
      
      return nil
    }
    
    func postOrderSearch(for value: T) -> BinaryTree? {
      guard self.value != nil else { return nil }
      
      if let leftChild = self.leftBinaryTree {
        if let foundNode = leftChild.postOrderSearch(for: value) {
          return foundNode
        }
      }
      
      if let rightChild = self.rightBinaryTree {
        if let foundNode = rightChild.postOrderSearch(for: value) {
          return foundNode
        }
      }
      
      print("Checking \(self.value!)")
      
      if self.value! == value {
        return self
      }
      
      return nil
    }
  }
  
  extension BinaryTree where T: Equatable {
    // This is an enum to store the different supported search methods
    public enum SearchMethod {
      case inOrder, preOrder, postOrder
    }
    
    // We'll need the root node for some of the functionality (and the
    // removal could start at any node in the tree) so it might as well be
    // a function that can be reused
    func findRootNode() -> BinaryTree? {
      guard self.value != nil else { return nil }
      
      var currentNode = self
      
      while currentNode.parent != nil {
        currentNode = currentNode.parent!
      }
      
      return currentNode
    }
    
    func remove(_ value: T, withSearchMethod searchMethod: SearchMethod) -> Bool {
      guard self.value != nil else { return false }
      
      var nodeToRemove: BinaryTree? = nil
      
      switch searchMethod {
      case .inOrder:
        nodeToRemove = self.inOrderSearch(for: value)
      case .preOrder:
        nodeToRemove = self.preOrderSearch(for: value)
      case .postOrder:
        nodeToRemove = self.postOrderSearch(for: value)
      }
      
      guard var foundNodeToRemove = nodeToRemove else { return false }
      
      let leftChild = foundNodeToRemove.leftBinaryTree
      let rightChild = foundNodeToRemove.rightBinaryTree
      let parent = foundNodeToRemove.parent
      
      if parent != nil {
        if leftChild == nil && rightChild == nil {
          if parent!.leftBinaryTree === foundNodeToRemove {
            parent!.leftBinaryTree = nil
          } else {
            parent!.rightBinaryTree = nil
          }
          
        } else if leftChild != nil && rightChild == nil {
          leftChild!.parent = foundNodeToRemove.parent
          
          if foundNodeToRemove.parent!.leftBinaryTree === foundNodeToRemove {
            foundNodeToRemove.parent!.leftBinaryTree = leftChild
          } else {
            foundNodeToRemove.parent!.rightBinaryTree = leftChild
          }
          
        } else if leftChild == nil && rightChild != nil {
          rightChild!.parent = foundNodeToRemove.parent
          
          if foundNodeToRemove.parent!.leftBinaryTree === foundNodeToRemove {
            foundNodeToRemove.parent!.leftBinaryTree = rightChild
          } else {
            foundNodeToRemove.parent!.rightBinaryTree = rightChild
          }
          
        } else {
          let smallestChild = leftChild!.count > rightChild!.count ? rightChild! : leftChild!
          let largestChild = leftChild!.count > rightChild!.count ? leftChild! : rightChild!
          
          largestChild.parent = foundNodeToRemove.parent
          
          if foundNodeToRemove.parent!.leftBinaryTree === foundNodeToRemove {
            foundNodeToRemove.parent!.leftBinaryTree = largestChild
          } else {
            foundNodeToRemove.parent!.rightBinaryTree = largestChild
          }
          
          let root = self.findRootNode()!
          
          root.addTree(smallestChild)
        }
      } else {
        if leftChild == nil && rightChild == nil {
          foundNodeToRemove.value = nil
          
        } else if leftChild != nil && rightChild == nil {
          foundNodeToRemove = leftChild!
          leftChild!.parent = nil
          
        } else if leftChild == nil && rightChild != nil {
          foundNodeToRemove = rightChild!
          rightChild!.parent = nil
          
        } else {
          let smallestChild = leftChild!.count > rightChild!.count ? rightChild! : leftChild!
          let largestChild = leftChild!.count > rightChild!.count ? leftChild! : rightChild!
          
          foundNodeToRemove = largestChild
          
          largestChild.leftBinaryTree?.parent = foundNodeToRemove
          largestChild.rightBinaryTree?.parent = foundNodeToRemove
          
          foundNodeToRemove.addTree(smallestChild)
        }
      }
      
      return true
    }
  }
  
  extension BinaryTree: CustomStringConvertible {
    public var description: String {
      guard value != nil else { return "{}" }
      var text = "\(value!)"
      
      text += " { \(leftBinaryTree?.description ?? ""), \(rightBinaryTree?.description ?? "")} "
      
      return text
    }
  }
  
  
  let sampleTree = BinaryTree(43)
  
  for i in 0..<100 {
    sampleTree.add(i)
  }
  
  print(sampleTree)
  
  print("Left tree: \(sampleTree.leftBinaryTree?.count)")
  print("Right tree: \(sampleTree.rightBinaryTree?.count)")
  
  for i in 0...10 {
    print(sampleTree.remove((10-i), withSearchMethod: .inOrder))
  }
  
  print(sampleTree.count)
  print(sampleTree)
  
