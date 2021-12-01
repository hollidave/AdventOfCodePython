prev =0
current =0
count =0
total=0
linechar=""
i =1
fp = open('adventday1.txt', 'r',encoding="utf-8")
all =fp.read().splitlines()
for line in fp:
	count+=1
	linechar = line.rstrip()
	current=int(linechar)
#	if current> prev and count > 1:
#		total+=1
		
	prev=current
#for i, line in enumerate(fp.readlines()):
#	print("here")
fp.close()
count=0

while count < len(all):
	  if count > 2:  
	  	if (int(all[count])+ int(all[count - 1]) + int(all[count - 2])) > (int(all[count - 1]) + int(all[count - 2]) + int(all[count - 3])):
	  		total+=1
	  		print 
	  count+=1
	  
print(total)
