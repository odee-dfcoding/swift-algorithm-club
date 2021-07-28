# Recursion
Recursion refers to something being defined in terms of itself or its type. In mathematics and computer science, this is most commonly seen where a function being defined refers to itself. Put more simply, a function is recursive when it calls itself.

To work properly, a recursive function must contain a base case and a recursive step. A base case refers to a scenario in which an answer is produced without recursion.

The Fibonacci sequence is a classic example of recursion. The first two numbers in the sequence are 1 and 1. This represents the base case as the value of each is produced without recursion. Subsequent numbers are defined as the sum of the previous two numbers. Following that definition, the third number in the sequence is 2 (the sum of 1 and 1), the fourth number in the sequence is 3 (the sum of 1 and 2), the fifth number in the sequence is 5 (2 + 3), and so on. After the base case of 1 and 1, the sequence is defined in terms of itself, thereby making it recursive.

## The Call Stack

In programming, recursion makes use of the call stack to store the results of each recursive function call. The call stack is a stack data structure that stores information about the function calls that have been made. 

Recursion works because of the stack's "last in, first out" behavior. When a function calls itself, it cannot return until that subsequent call has returned. This allows a function to break itself down into smaller pieces of the problem that it depends on, receive the result of those smaller problems, and then reach its solution. 

For example, consider the following code:

```swift
func pullUsername() -> String {
  return someField.text
}

func formatUsername() -> String {
  let username = pullUsername()
  
  return username.uppercased()
}

func setTitle() {
  navigationItem.title = formatUsername()
}
```

When `pullUsername()` gets called, the call stack essentially looks like: 

<img src="Images\CallStackExample.jpeg" alt ="A stack with setTitle at the base, formatUsername above it, and pullUsername at the top">

In the Fibonacci example, if you are solving for the fifth number in the sequence, then the function would call itself asking for the third and fourth number in the sequence. Each of these would in turn call itself asking for the previous two numbers and so on until they reached the base case. 

At that point, each function call would have been stored in the call stack. The topmost call stored would be the last call made (last in, first out), which would be the base case of asking for the first number in the Fibonacci sequence. That call would return 1. Next, the call asking for the second number in the sequence would return 1. The next call would be asking for the third number and would add together the result from the previous two calls and then return 2. This would continue until the last call in the call stack would add the third and fourth number in the sequence together and return the final result of 5.

It's important to note that you can solve this with iteration (loops), but you need to create your own stack for keeping track of the results of each sub-problem. In many cases, this can be more efficient. For more complex recursive problems, however, the call stack helps simplify your solution.


## How to Use Recursion in Swift

Let's continue with the Fibonacci sequence example by implementing a recursive solution in Swift.

The general formula for the body of a recursive function is:
1. Perform some portion of the work
2. Check for the base case
	1. If it is the base case:
		- Do any last work needed and return from the function
	2. If it isnt' the base case:
		- Do any work needed during this pass and then call the function with updated values

### Base Case

Recall that the base case is the state that indicates that recursion should end. In the context of solving for a number in the Fibonacci sequence, this might look as follows:

```swift
func fib(_ n: Int) -> Int {
	guard n > 2 else { return 1 }

	fatalError() // to silence compiler error
}
```

Here, `n` refers to the position in the sequence whose value you want to find. If `n` is 1 or 2, then the answer is 1. This is a base case because it doesn't involve recursion and instead provides a concrete answer.

### Recursive Case

Now that the function solves for the base case, it's time to solve for the recursive case. If `n` is greater than 2, we simply need to call the function to get the value of the last position, call the function again to get the value two positions prior, and finally add the two results together.

```swift
func fib(_ n: Int) -> Int {
	guard n > 2 else { return 1 }

	return fib(n-1) + fib(n-2)
}
```

That's it! If `n` is larger than 2, then the function finds the answer by finding the answer at `n-1` and `n-2`, both of which are solved in the base case. This works for an `n` of 3 and an `n` of 1000 (but keep in mind that it will take quite a while to find the solution for `n=1000` - the time complexity is ~ O(1.6^n)).

Often you'll see the fibonacci solution written as follows:

```swift
func fib(_ n: Int) -> Int {
	guard n > 1 else { return n }

	return fib(n-1) + fib(n-2)
}
```

The result here is equivalent to how we wrote the answer previously. If `n` is 1 or smaller, the value is equal to `n`. If `n` is 2, then the answer to `fib(n-1) + fib(n-2)` is `1 + 0 = 1`.

### Avoid Endless Recursion

Consider what would happen if you remove the base case from the solution. 

```swift
func fib(_ n: Int) -> Int {
	return fib(n-1) + fib(n-2)
}
```

Rather than recursion stopping once the function calls itself with a parameter value of 1 or 2, it will continue to call itself forever with smaller and smaller parameter values. Just like with loops, we need to make sure there is a clear end to recursion. To avoid this problem, ensure that your recursive functions have a proper base case and that each pass through the function moves _toward_ its execution.

## When to Use Recursion

We mentioned previously that recursion problems can also be solved by iteration. So when should you use recursion versus iteration? Well, like most things, it's ultimately a judgment call you need to make. 

Recursion is great for any problem that involves doing the same thing multiple times, especially when you don't know beforehand how many times to perform the operation and otherwise would need to keep track of the result of each operation. In these cases, recursion simplifies the problem by removing the need to keep track of indexes and other values.

However, recursion can also be less efficient than iteration. In the Fibonacci sequence example, we aren't keeping track of the values as we discover them at each position, so it must be recalculated over and over again as we go through and solve for values at position 1, 2, 3, 4, 5, etc. While using iteration doesn't necessarily solve this, it would be much more natural to keep track of results in that scenario. Just keep in mind the complexity of your solution and do your best to find what is efficient and pragmatic.

### Recursive Data Structures

Many data structures are inherently recursive. You'll learn about trees later and get a feel for that.

As a preview to recursion and data structures, let's have a look at Linked Lists. Linked Lists can be written both iteratively and recursively. The following represents a recursive Linked List implementation:

```swift
	class RecursiveLinkedLists<T> {
		var data: T?
		weak var preceding: RecursiveLinkedList<T>?
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
		
		func remove(atIndex index: Int) -> T? {
			if index > self.count {
				return nil
			} else {
				if index == 0 {
					if let preceding = preceding {
						preceeding.proceeding = self.proceeding
						self.proceeding.preceding = preceding
					}  else {
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
```

Instead of using nodes pointing to each other, it just has one data point, the list of elements before it, and the list of elements after it.

This means you only have one class and don't have to worry about creating a Node.

First, `count` is a computed property that uses recursion. It returns the `count ` for the current list, rather than the "whole list". It starts with 1 for the current instance, and adds the next list's count, or 0 if it's nil (that's the base case). 

The `append(_:)` function will add an element to the end of the list. First, it attempts to unwrap `proceeding` to see if there is a list behind it already. If there is, then it gets asked to append the data. If there isn't (which is the base case), then the recursion has reached the end of the list. It can wrap the data in a list assigned to `proceeding`, and make sure the new list has the current list as its `preceding` property.

The `remove(atIndex:)` function might look a little more challenging, but a lot of that comes from the check to make sure the `index` is within range. Setting that aside, it goes on to check if the `index` is 0, which is a bit flipped from `append(_:)`. `append(_:)` checks for the base case last, instead of first. As long as the recursion is well designed, either way works fine. It then checks if there's a list before it. If there is (which should be any item except the very first), it can just connect the list before itself with the list after. If it is the first item, then it can just assign the next list's properties to itself. If the index isn't 0, the list can just tell the next list to remove it. Note that it passes `index - 1` instead of `index`. Remember, recursion only works if a function calls itself with a smaller amount of work. If you just passed `index`, then `index == 0` would never be true and the function would run forever. This is just like using a while loop without updating its condition, just with recursion instead.


## Summary

If recursion seems confusing, don't worry! It's a new concept that takes some time to absorb. Recursion will come up more as we start to talk about the tree data structure and you'll spend more time practicing these concepts then. In the meantime, if you are interested in becoming an app developer, we strongly recommend practicing recursive algorithms as a way to prepare for technical interviews. You probably won't use recursion every day, and maybe not even every month, but it's an important concept that prospective employers ask you to demonstrate mastery over so they can gage how well you can think through the call stack. You can do this. It just takes practice.

_Written by Digital Flagship_
