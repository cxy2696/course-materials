def closest_power(base, num):
    result = 0
    if base > num: 
        result = 0
    elif base == num:
        result = 1
    else:
        for i in range(1, int(num)):
            if abs(base**i - num) <= abs(base**(i + 1) - num):
                result = i
                break
    return result

def getSublists(L, n):
    listofsublists = [] 	
    for i in range(len(L)-n+1):
        listofsublists.append(L[i:i+n])
		#create sublists of length n for every i and adds this sublist to master sublist
    return listofsublists

def keysWithValue(aDict, target):
    '''
    aDict: a dictionary
    target: an integer
    '''
    # Your code here

    ansList = []

    for key in aDict.keys():
        if aDict[key] == target:
            ansList.append(key)

    return ansList

dictionary = {1: 1, 2: 2, 3: 3, 4: 3}
dictionary_1 = {1:1}

print(keysWithValue(dictionary, 3))
print(keysWithValue(dictionary_1, 3))

def max_val(t):
    """ t, tuple or list
        Each element of t is either an int, a tuple, or a list
        No tuple or list is empty
        Returns the maximum int in t or (recursively) in an element of t """
    # Your code here

    def openItem(term):
        newList = []
        for item in term:
            if type(item) == int:
                newList.append(item)
            else:
                newList += openItem(item)

        return newList

    sortingList = openItem(t)

    maximum = sortingList[0]

    for item in sortingList:
        if maximum < item:
            maximum = item

    return maximum


print(max_val((5, (1,2), [[1],[2]])))
print(max_val((5, (1,2), [[1],[9]])))

def general_poly (L):
    """ L, a list of numbers (n0, n1, n2, ... nk)
    Returns a function, which when applied to a value x, returns the value 
    n0 * x^k + n1 * x^(k-1) + ... nk * x^0 """
    def to_apply (x):
        n = 0
        for i in L:
            n = x*n + i
        return n
    return to_apply