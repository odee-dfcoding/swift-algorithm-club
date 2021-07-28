# Memory

## Overview
There are hundreds of programming languages, and compared to others, Swift is fairly high level. That's part of what makes it a good language to start with. Higher level languages focus more readability and ease of use. Lower level languages allow more control, but typically aren't as approachable and tend to leave room for human errors. For example, Swift will remove objects you are done with for you (usually), but in C++, if you don't delete things in code when you're done with them, you could get a crash. 

As an example, in Swift, it's easy to add three numbers.

	let x = 1
	let y = 2
	let z = 3
	let sum = x + y + z
	
In something like Assembly, which is one of the lowest level languages, the same thing looks a little different since the programmer needs to put data into the working memory manually.

		ORG 100
		ENTRY
		LDA NU1
		ADD NU2
		ADD NU3
		STA ANS
		DMP
		HALT
	NU1,	DEC 1
	NU2,	DEC 2
	NU3,	DEC 3
	ANS,	HEX 0
	
(If that doesn't makes sense to you, don't worry. I had to find an example that was explained so I knew what Swift example to write.)

This example starts by saying where it'll keep data it's working with, starts the program, loads `NU1`, then adds `NU2` and `NU3` to the same space before saving the answer.

Aside from appreciating Swift more, I wanted to share that to show how much Swift does behind the scenes. While you don't need to do so much manually, understanding what's going on can help you write faster code in more advanced apps.

## What is Memory?

There are a lot of different ways people interpret memory outside of tech in general. In this context, it's referring to RAM, which is not an SD card, hard drive, or the storage of an iPhone. iOS devices typically advertise how much permanent storage they have, so RAM or memory may be interpreted differently depending on the devices someone uses. If you go to Apple's website and look at the options for an iPhone, the only capacities you'll see are anything from 64 GB to 512 GB. That's how much you can save to permanent storage, or "disk". If you look at Macs though, you can see different options for storage and memory since Apple offers multiple configurations for them. If you've looked at Android phones, then you've probably seen that they talk about memory a lot more since there are so many more options. Regardless of platform, anything that can run apps is going to have a certain amount of memory (much less than 512 GB for the foreseeable future).

There are a few differences between memory and storage. First, memory is a lot faster, but it's also a lot more expensive. Storage is cheaper, but much slower. So, they get used for different things. You've seen in earlier courses that you can save data so you can load it back into the app if the it's closed. That would be storage. It's great for saving things long-term, but wouldn't be great for storing all the data in your variables and classes while the app is running because of the delay. Memory is where everything your app is currently working with is saved. It also gets wiped after someone quits your app so another one can keep its own data there.

You can compare them to a file cabinet and a desk with a cleaning crew that shreds anything on it whenever you leave. You have to pull out files from the cabinet (aka storage) and put it on your desk (memory) to work on it. Anything that you don't put back into the cabinet gets lost forever.

The one difference between memory and your desk is that you can't just stack things on top of everything else until you have a small mountain. Memory is more organized. Each space can fit just one thing, and each spot has a unique address.

## Why Does This Matter?

While you haven't had to worry about memory so far, it does become important as you advance in your coding skills. Depending on the app, you may start to run into out of memory errors. Or maybe you're working with an app that uses C++ for some things, which means you need to remember to wipe variables from memory when you're done with them since it won't do it for you. In the context of the upcoming topics, though, just knowing what it is and a little bit about how it works is going to go a long way towards understanding the topics we'll cover.