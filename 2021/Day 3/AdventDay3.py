horizontal = 0
count2 = 0
depth = 0
integer = ""
lines = ""
lines2 = ""
number1 = 0
number2 = 0

def getInt(n,char): 
    integer = char 
    integer = int(integer[n:n+1])
    return integer

def checkVal(n,direction,array): 
    count = 0
    total = 0
    while count < len(array): 
        total += getInt(n,array[count][0] )
        count+=1  
            
    if count > 0 and (total / count) < 0.5 and direction == "most":
        return 1
    if count > 0 and (total / count) >= 0.5 and direction == "least":
        return 1
    return 0

def remove(n,remove,array): 
    count = 0
    total = 0 
    while count < len(array):
        if len(array) == 1:
            return 
        if getInt(n,array[count][0]) == remove:
            array.pop(count)
        else:
            count+=1       

with open("H:\Advent\Day3.txt") as textFile:
    lines = [line.rstrip().split() for line in textFile] 

with open("H:\Advent\Day3.txt") as textFile:
    lines2 = [line.rstrip().split() for line in textFile] 

while count2 < 12:
    check = checkVal(count2, "most",lines)     
    remove(count2,check,lines)  
    count2+=1  
    
count2 = 0  
while count2 < 12:
    check = checkVal(count2, "least",lines2)    
 
    remove(count2,check,lines2)
    count2+=1 
     
count2 = 0 
print(lines[0][0])
while count2 < 12: 
    number1 += getInt(count2, lines[0][0]) * 2**(12 - count2 - 1) 
    number2 += getInt(count2, lines2[0][0]) * 2**(12 - count2 - 1) 
    count2 += 1

print(number1, number2, number1 * number2) 