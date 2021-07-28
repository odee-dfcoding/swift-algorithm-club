func fib(_ n: Int) -> Int {
    guard n > 1 else { return n }
    return fib(n-1) + fib(n-2)
}


print(fib(4))

print(fib(10))

print(fib(15))
