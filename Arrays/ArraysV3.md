# Overview

Arrays are not unique to Swift. Most tother languages have their own arrays, and many of those act more like traditional arrays. Swift Arrays act more like lists, since you can add and remove as many items as you need to without worrying about memory. Java actually has a similar type, although it's named a little more accurately: ArrayList. Lists will get covered more in a later section, but for now we'll talk about traditional arrays.

## Why is This Important?

While Swift doesn't have a collection that behaves like true arrays, understanding how they work is still important. 

First, knowing how arrays typically work is going to be important when we start talking about all the different data structure options you can work with. Some will be based on traditional arrays, and that plays a role in how well they perform in different scenarios.

Second, while you can work with Swift Arrays as if they were lists, behind the scenes they are actually normal arrays. Swift just handles the concerns we'll talk about next for you. This means that they're subject to the same performance considerations as arrays in other languages. As you build more and more complex apps, you might find that creating your own collection based on a different data structure can improve performance.

Finally, questions about these concepts tend to come up in technical interviews. While the first two points apply to anyone working with Swift, this one is mostly for anyone interested in pursuing a career in app development. 

## What is an Array?

An array is a collection of data, which you've already seen as you've worked through the various projects in the previous courses. There's more happening that hasn't come up since Swift hides it, though.

This section will start to talk about memory, so feel free to revisit that section if you want a refresher.

When you create a variable, Swift can find some random spot in memory that it can store it in. With an array, everything inside must be next to it's neighbors. So, if you have `myArray = [1, 2, 3, 4]`, then `myArray[0]` has to be next to `myArray[1]`, which also has to be next to `myArray[2]`, and so on. 

Since everything needs to be next to each other, arrays need to know how many elements they'll have so they can find a spot in memory that's big enough to fit everything. But, you can make an array just with `var myArray: [Int] = []`, which doesn't say anything about its size.

Objective-C, the original language for iOS apps, illustrates the size requirement better.

```objective-c
	int myArray[4];
```
	
That line will make an array for ints and can store 4 numbers. Swift Arrays actually work the same way, but they take care of things like that for you.

## Why Don't Swift Arrays Have a Size Limit?

The size limit might not make a lot of sense given what you've done with Swift Arrays so far. In your EmojiDictionary, you didn't have to worry about how many Emojis you entered. Also, people were writing apps in Objective-C before Swift came along (and still do actually). 

Developers have been writing code for a long time, and they came up with a strategy to handle arrays when they don't know how much data is going to be in it.

Initially, I thought they just made the arrays much bigger than they expected they needed. This doesn't work for two reasons.  One, as you've read, there's only a limited amount of memory on a device. If every array was set to story 10,000,000 items, the app would crash because all the memory was in use. Two, there's always an edge case that would end up trying to add 10,000,001 things. There is a better way, though.

When first creating an array, it might have a size limit of 10 items. Once a user tries adding an 11th item, Swift will create a new array that's some multitude larger than the current array. It will then copy the original 10 items and then add the 11th to the new array. Since the new array is always double or triple (or some  multiple of the current size), it's not copying the data every time someone adds something, which would really slow down the app as it grew. 

Apple's documentation on Swift Arrays says:

"Every array reserves a specific amount of memory to hold its contents. When you add elements to an array and that array begins to exceed its reserved capacity, the array allocates a larger region of memory and copies its elements into the new storage. The new storage is a multiple of the old storage’s size. This exponential growth strategy means that appending an element happens in constant time, averaging the performance of many append operations. Append operations that trigger reallocation have a performance cost, but they occur less and less often as the array grows larger.

If you know approximately how many elements you will need to store, use the reserveCapacity(_:) method before appending to the array to avoid intermediate reallocations. Use the capacity and count properties to determine how many more elements the array can store without allocating larger storage."[^1]

[^1]: https://developer.apple.com/documentation/swift/array

## What Happens When Users Remove Data?

Given just what the previous section mentions, it might seem like there's still a problem with arrays taking up too much memory. If someone were to add 10,000,000 items to one of your arrays in code, and then move all of them to another array, and then another, it looks like it runs into the same problem as setting every array to have 10,000,000 spaces. 

Just like how arrays will grow when needed, they'll also shrink when they can. There is a slight difference in strategy though.

If an array would shrink to half it's size as soon as it was half full, performance would suffer. In EmojiDictionary, if the array had 11 items and could hold up to 20, then it would shrink as soon as someone removed an emoji. It would also grow as soon as they added another. If you have an indecisive user, they might keep deleting and adding a different emoji multiple times. The array would constantly be copying itself to a new location in memory. That's not good for performance.

To get around this, arrays will shrink less than what they could. So, an array that could hold 60 items might shrink to 30 once it only has 20 elements. 

## What's Next?

We'll get more in-depth as we start covering the pros and cons of different data structures, but the last note for arrays is that you can access elements in constant time. `myArray[1]` grabs the second element in an array just as quickly as `myArray[10_000_000]` will access the 9,999,999th element.