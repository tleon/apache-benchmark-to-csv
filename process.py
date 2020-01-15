#! python3

f = open('results', 'r')
content = f.readlines()
f.close()

content = content[13:]

arrayOfLines = {}

for line in content:
    if line.find(':') != -1:
        tmp = line.split(':')
        arrayOfLines[tmp[0]] = tmp[1][:-1].strip()


f = open('results.csv', 'a+')

for item in arrayOfLines:
    f.write(arrayOfLines[item] + ';')
f.write('\n')
f.close()
