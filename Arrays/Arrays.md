# Array

Arrays are one of the simplest, but most commonly used, data structures. In many programming languages, arrays are a primitive type, meaning they aren't objects and don't have methods or properties. Swift arrays are structs, and contain significantly more built-in functionality than primitive arrays. Understanding Swift arrays as compared to primitive arrays will help you to more appropriately use arrays in solving problems, whether in your apps or in technical interviews.

## Primitive Arrays

Arrays are defined as an ordered list of elements, where each element can be accessed by its index. The seemingly simple Swift array that you're familiar with actually handles a lot of complexity for you that primitive arrays didn't. Let's talk about performing standard array operations on a primitive array to illustrate this concept.

### Creating Primitive Arrays

Each item in a primitive array must be stored in a contiguous space in memory for access by index to be possible. This means if you have a list of integers 1, 2, 3, and 4, that each integer needs to be stored in that order next to the last integer. 

Consequently, a programmer creating a primitive array needs to specify how many spaces to reserve for items in the array so that the spot in memory chosen for the array can fit all of the array's elements side by side. For example, in Objective-C (the original language for creating iOS applications), you declare a new array with space for four integers as follows:

```objective-c
int myArray[4];
```

These instructions ensure that the array has space for four integers. You'll get a runtime error if you try to add or access a fifth element to or from the array.

### Accessing Items in Primitive Arrays

Access in primitive arrays is very similar to Swift arrays, but without properties like `first` and `last`. You access elements by subscripting the array with the index you would like to access.

### Adding Items to Primitive Arrays

You add items to primitive arrays using subscript and assignment syntax. In Objective-C:

```objective-c
myArray[0] = 1;
myArray[1] = 2;
myArray[2] = 3;
```

There are no methods to add more than one item at a time, append, or insert. All of these operations need to be performed manually, one element at a time. For example, if you know that your array already has 3 items in it and you want to add a fourth, you would have to do so with the subscript and assignment syntax:

```objective-c
myArray[3] = 4;
```

If you wanted to add a fifth item to the array, you would need to create a new array with sufficient space reserved, copy over all of the items from the previous array, then add the fifth item to the new array. Because this can happen often, it's common to create more space than needed.

```objective-c
int newArray[10];
        
for (int i=0; i<4; i++) {
  newArray[i] = myArray[i];
}

newArray[4] = 5;
```

If you wanted to insert an item into the middle of the array at index 2, you would need to move all of the items at and beyond that index over one index to make space for the new item.

```objective-c
for (int i=4; i>=2; i--) {
  newArray[i+1] = newArray[i];
}
        
newArray[2] = 6;
```

### Removing Items in Primitive Arrays

Nothing is every truly deleted in a computer in that the memory or storage space continues to exist and continues to represent _something_. When you delete something, you're either removing the reference to that space in memory and indicating that it can be used by something else, or you're randomizing the _something_ that's in there so that it doesn't represent anything valuable.

When removing items from primitive arrays, you need to manually shift all of the other items to fill that area because you can't actually _remove_ the item. You could also have a value representing "nothing" like zero for integers, but typically you simply keep track of where the last item in the index is that's a real item, and if you want to remove a value from the middle of the array you simply move all the items after it to the left by 1.

```objective-c
for (int i=2; i<4; i++) {
  newArray[i] = newArray[i+1];
}
```

### Item Lookup In Primitive Arrays

To look for a specific item in a primitive array, you must loop through the array until you find that item. For example, if you want to find the index of the integer `3` in `newArray`, you can do the following:

```objective-c
int indexOf3;

for (int i=0; i<5; i++) {
    if (newArray[i] == 3) {
        indexOf3 = i;
        break;
    }
}
```

## Swift Arrays

While you won't ever use primitive arrays in Swift, understanding primitive arrays give you a deeper understanding of memory and how various operations impact performance. This is important because everything you just learned about primitive arrays is happening when you work with Swift arrays, only `Array` comes packed with features to ensure that you don't have to do them it manually. However, you still need to think of the performance impact of various operations like adding, removing, and looking up items.

### Adding Items To Swift Arrays

Apple's documentation on Swift arrays provides some insight into what happens under the hood when adding an item to a Swift array:

> Every array reserves a specific amount of memory to hold its contents. When you add elements to an array and that array begins to exceed its reserved capacity, the array allocates a larger region of memory and copies its elements into the new storage. The new storage is a multiple of the old storage’s size. This exponential growth strategy means that appending an element happens in constant time, averaging the performance of many append operations. Append operations that trigger reallocation have a performance cost, but they occur less and less often as the array grows larger.

> If you know approximately how many elements you will need to store, use the `reserveCapacity(_:)` method before appending to the array to avoid intermediate reallocations. Use the capacity and count properties to determine how many more elements the array can store without allocating larger storage.[^1]

[^1]: https://developer.apple.com/documentation/swift/array

Essentially, if you append an item to a Swift array and the array has space allocated in memory for that item, then the operation is O(1). However, if you have an array with a size limit of 10 items and try to add an 11th item, Swift will create a new Array that's some multiple larger than the current array, copy the original 10 items over to the new array, and then add the 11th item to the array. This operation is O(n). However, this occurs infrequently since the array size grew by a multiple of the original array. This ensures that the operation with complexity of O(n) doesn't happen every time a new item is added to the array.

When inserting rather than appending a new item, every item at the insertion index and beyond must be shifted back, resulting in a runtime complexity of O(n). 

### Removing Items From Swift Arrays

Similar to adding items to Swift arrays, there is more complexity than meets the eye when removing items. Just like with primitive arrays, removing an item from anywhere other than the end of the array requires that every item beyond it be shifted up, resulting in a runtime complexity of O(n). 

When possible, Swift will also shrink an array's reserve capacity for optimal memory management. However, to avoid multiple memory reallocations in a situation where an item is removed, then another added, then another removed, then another added, reserve capacity will always shrink to still be _more_ than the number of items currently in the array. For example, an array with a reserve capacity of 60 items might shrink to have a reserve capacity of 30 once there are 20 items in the array. When another item is added, there will still be sufficient capacity for that item.

### Item Lookup In Swift Arrays

Just as with primitive arrays, item lookup requires looking at every item stored in the array until the item is found, resulting in a runtime complexity of O(n). If you have a large collection of items that you will need to frequently search, it might make sense to use a data structure better suited to lookup.

## Array Wrapup

With Swift, you don't usually need to think about any of this - Swift does everything for you. However, there may be scenarios where you need to be aware of the performance impacts of array operations. For example, you might have an array that you expect to be incredibly large and may want to avoid any O(n) operations. In this example, you might use the `reserveCapacity(_:)` method to set the expected number of items and avoid unecessary reallocations. Or you might decide to use a Swift set instead of an array so that searching for a specific item in the array will be O(1) rather than O(n) (more on that later).

Swift arrays are powerful and simple to use. They just magically work. But exposing the magic and understanding how they work will make you a better programmer. If you're ever in doubt about how an array method works, look at the Discussion section of the method's documentation.