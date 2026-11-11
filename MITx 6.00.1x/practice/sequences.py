x = (1, 2, (3, 'John', 4), 'Hi')
print(x[0:1])
print(x[0:-1])
type(x[0:-1])
print(len(x))
print(3 in x[2])

x = [1, 2, [3, 'John', 4], 'Hi']
print(x[0])
print(x[2])
print(x[-1])
print(x[2][2])
print(x[0:1])
print(2 in x)

listA = [1, 4, 3, 0]
listA.reverse()
print(listA)
listA.extend([4, 1, 6, 3, 4])
print(listA)
print(listA.index(1))
listA.insert(0,100)
print(listA.pop(4))
print(listA)


listB = ['x', 'z', 't', 'q']
print(listA+listB)
listA.sort()
print(listA)

listB.sort()
listB.pop()

listB.count('a')
listB.remove('a')

aList = [0, 1, 2, 3, 4, 5]
bList = aList
aList[2] = 'hello'
aList == bList
print(aList is bList)
print(bList)

cList = [6, 5, 4, 3, 2]
dList = []
for num in cList:
    dList.append(num)
cList == dList

cList is dList

cList[2] = 20
cList

dList

def applyEachTo(L, x):
    result = []
    for i in range(len(L)):
        result.append(L[i](x))
    return result

def square(a):
    return a*a

def halve(a):
    return a/2

def inc(a):
    return a+1

applyEachTo([inc, square, halve, abs], -3)
applyEachTo([inc, square, halve, abs], 3.0)
applyEachTo([inc, max, int], -3)

animals = {'a': 'aardvark', 'b': 'baboon', 'c': 'coati'}
animals['d'] = 'donkey'
print('baboon'in animals)
animals.keys()
print(len(animals['a']))

del animals['b']
len(animals)

print(animals.values())

animals = { 'a': ['aardvark'], 'b': ['baboon'], 'c': ['coati']}
animals['d'] = ['donkey']
animals['d'].append('dog')
animals['d'].append('dingo')

print(how_many(animals))

secretWord = 'apple' 
lettersGuessed = ['e', 'i', 'k', 'p', 'r', 's']


def hangman(secretWord):
    '''
    secretWord: string, the secret word to guess.

    Starts up an interactive game of Hangman.

    * At the start of the game, let the user know how many 
      letters the secretWord contains.

    * Ask the user to supply one guess (i.e. letter) per round.

    * The user should receive feedback immediately after each guess 
      about whether their guess appears in the computers word.

    * After each round, you should also display to the user the 
      partially guessed word so far, as well as letters that the 
      user has not yet guessed.

    Follows the other limitations detailed in the problem write-up.
    '''
    # FILL IN YOUR CODE HERE...
    print("Welcome to the game Hangman!")
    print("I am thinking of a word that is " + str(len(secretWord)) +" letters long")
    print("-----------")
    lettersGuessed = []
    guesses = 8
    # while all the letters of secretWord are not yet in lettersGuessed and guesses left is more than 0
    while not isWordGuessed(secretWord, lettersGuessed) and guesses > 0:
        # print first line
        print("You have " + str(guesses) +" guesses left")
        # print second line
        print("Available Letters: " + getAvailableLetters(lettersGuessed))
        # print third line
        # if user input a letter that has already been entered, reprompt for letter
        while True:
            guessLetter = raw_input("Please guess a letter: ").lower()
            if guessLetter in lettersGuessed:
                print("Oops! You've already guessed that letter: " + getGuessedWord(secretWord, lettersGuessed))
                print("-----------")
                print("    You have " + str(guesses) +" guesses left")
                print("Available Letters: " + getAvailableLetters(lettersGuessed))
            else:
                break
        lettersGuessed += guessLetter
        # print last line
        # if correctly guessed secret word
        if isWordGuessed(secretWord, lettersGuessed):
            print("Good guess: " + getGuessedWord(secretWord, lettersGuessed))
            print("-----------")
            print("Congratulations, you won!")
            break
        # else if the guess letter is in secret word
        elif guessLetter in secretWord:
             print("Good guess: " + getGuessedWord(secretWord, lettersGuessed))
             print("-----------")
        # else the guess letter is not in secret word
        else:
            print("Oops! That letter is not in my word: " + getGuessedWord(secretWord, lettersGuessed))
            print("-----------")
            guesses -= 1
        # if ran out of guesses
        if guesses == 0:
            print("Sorry, you ran out of guesses. The word was " + secretWord + ".")
            
# Example Usage:
secretWord = 'apple' 
lettersGuessed = ['e', 'i', 'k', 'p', 'r', 's']
print(isWordGuessed(secretWord, lettersGuessed))