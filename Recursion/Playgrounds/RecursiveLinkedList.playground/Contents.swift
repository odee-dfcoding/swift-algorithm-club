class RecursiveLinkedList<T> {
    var data: T
    var preceding: RecursiveLinkedList<T>?
    var proceeding: RecursiveLinkedList<T>?
    var count: Int {
        return 1 + (proceeding?.count ?? 0)
    }
    
    init(_ data: T) {
        preceding = nil
        proceeding = nil
        self.data = data
    }
    
    func append(_ data: T) {
        if let proceeding = proceeding {
            proceeding.append(data)
        } else {
            proceeding = RecursiveLinkedList<T>(data)
            proceeding!.preceding = self
        }
    }
    
    func remove(atIndex index: Int) {
        if index > self.count {
            return
        } else {
            if index == 0 {
                if let preceding = preceding {
                    preceding.proceeding = self.proceeding
                } else {
                    guard let proceeding = proceeding else { return }
                    
                    self.data = proceeding.data
                    self.preceding = nil
                    self.proceeding = proceeding.proceeding
                }
            } else {
                proceeding?.remove(atIndex: index - 1)
            }
        }
    }
}

extension RecursiveLinkedList: CustomStringConvertible {
    var description: String {
        get {
            var description = ""
            if let preceding = preceding {
                description += ", \(data)"
            } else {
                description = "[\(data)"
            }
            
            if let proceeding = proceeding {
                description += proceeding.description
            } else {
                description += "]"
            }
            
            return description
        }
    }
}

var testList = RecursiveLinkedList<Int>(4)

for i in 0...100 {
    testList.append(i)
}

print(testList)
print(testList.count)
testList.remove(atIndex: 41)

print(testList)
print(testList.count)

testList.remove(atIndex: 0)
print(testList)

for _ in 1...101 {
    testList.remove(atIndex: 0)
}

print(testList)
