#!/usr/bin/env python3
def to_fizzbuzz(n):
    if n % 15 == 0:
        return "FizzBuzz"
    elif n % 3 == 0:
        return "Fizz"
    elif n % 5 == 0:
        return "Buzz"
    else:
        return n

while True:
    try:
        n = int(input()) # Synchronous. We wait for input.
        print("{0} => {1}".format(n, to_fizzbuzz(n)))
    except EOFError:
        break
    except ValueError:
        print("error: cannot process input")
