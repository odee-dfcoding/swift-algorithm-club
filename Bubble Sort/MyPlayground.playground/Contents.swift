import Foundation

var array = [4,2,1,3]

print("before:",array)
print("after:", bubbleSort(array))
print("after:", bubbleSort(array, <))
print("after:", bubbleSort(array, >))

struct DFArray<T> {
    var data: [T]
    var count: Int
    private var capacity: Int
    
    init(_ size: Int) {
        data = []
        count = 0
        capacity = size
    }
    
    subscript(index: Int) -> T {
        get {
            return data[index]
        }
        
        set(newValue) {
            data[index] = newValue
        }
    }
}
