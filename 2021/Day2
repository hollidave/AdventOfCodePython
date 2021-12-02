horizontal = 0
aim = 0
depth = 0
linechar=""

fp = open('H:\Advent\Day2.txt', 'r',encoding="utf-8") 
for line in fp: 
	linechar = line.rstrip().split() 

	if linechar[0] == "forward":
		horizontal += int(linechar[1]) 
		depth = depth + (aim * int(linechar[1]))
	elif linechar[0] == "up":
		aim -= int(linechar[1])
	elif linechar[0] == "down":
		aim += int(linechar[1]) 
fp.close() 
	   
print(horizontal * depth )
