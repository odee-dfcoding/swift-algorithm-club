public class BinaryTree<T> {
    public var value: T
    private var leftBinaryTree: BinaryTree?
    private var rightBinaryTree: BinaryTree?
    weak private var parent: BinaryTree?
    public var count: Int {
        return 1 + (leftBinaryTree?.count ?? 0) + (rightBinaryTree?.count ?? 0)
    }
    
    init(data value: T) {
        self.value = value
        
        leftBinaryTree = nil
        rightBinaryTree = nil
    }
    
    func append(_ value: T) {
        if leftBinaryTree == nil && rightBinaryTree == nil {
            leftBinaryTree = BinaryTree(data: value)
            leftBinaryTree!.parent = self
        } else if leftBinaryTree != nil && rightBinaryTree == nil {
            rightBinaryTree = BinaryTree(data: value)
            rightBinaryTree!.parent = self
        } else if let leftBinaryTree = leftBinaryTree, let rightBinaryTree = rightBinaryTree {
            leftBinaryTree.count > rightBinaryTree.count ? rightBinaryTree.append(value) : leftBinaryTree.append(value)
        }
    }
    
    func testPrint() {
        print("[\(value)]\n")
        
        if let leftBinaryTree = leftBinaryTree, let rightBinaryTree = rightBinaryTree {
            print("[\(leftBinaryTree.value)]  [\(rightBinaryTree.value)]")
        }
    }
}

var test = BinaryTree(data: 45)
test.append(32)
test.append(45)
test.append(2340)

print(test.count)

test.testPrint()
