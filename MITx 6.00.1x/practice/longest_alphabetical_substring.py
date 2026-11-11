"""
Created on Tue Jun  4 11:03:49 2024

@author: xinyi
"""
# 3
s = 'abcedefrixdgsegef'
count = 0
maxcount = 0
result = 0
for char in range(len(s) - 1):
    if (s[char] <= s[char + 1]):
        count += 1
        if count > maxcount:
            maxcount = count
            result = char + 1
    else:
        count = 0
startposition = result - maxcount
print(s[startposition:result + 1])