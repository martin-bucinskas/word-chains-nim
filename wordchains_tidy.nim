import strutils, sequtils, sugar, tables, algorithm, std/[terminal], random, os

var dictionary = initTable[int, seq[string]]()
var globalStack: seq[string] = @[]

proc isNeighbour(current: string, next: string): bool =
    var count = 0

    for i in 0..len(current) - 1:
        if current[i] != next[i]:
            count += 1
            
        if count > 1:
            return false
    
    return true

proc existsInDictionary(word: string): bool =
    if dictionary[len(word)].contains(word):
        return true
    return false

proc validPair(first: string, second: string): bool =
    if len(first) != len(second):
        return false
    if not existsInDictionary(first):
        return false
    if not existsInDictionary(second):
        return false
    return true

proc loadDictionary(file: string): void =
    for line in lines file:
        var currentLength = len(line)

        if not dictionary.hasKey(currentLength):
            dictionary[currentLength] = @[]

        dictionary[currentLength].add(line)

proc findEndOfChain(starting: string, ending: string, list: seq[string]): bool =
    var stack = list

    if stack.find(starting) == -1:
        stack.add(starting)

    # if len(stack) > 100:
    #     return false

    if starting == ending:
        return true
    
    for possibleWord in dictionary[len(starting)]:
        if isNeighbour(starting, possibleWord):
            if find(stack, possibleWord) == -1:
                stack.add(possibleWord)
                if findEndOfChain(possibleWord, ending, stack):
                    globalStack.add(possibleWord)
                    return true
                let tmp = stack.pop()
                
    return false

proc findChain(starting: string, ending: string): seq[string] =
    var found = false

    while not found:
        var res = findEndOfChain(starting, ending, globalStack)
        reverse(globalStack)

        if res:
            found = true
            return globalStack

proc setRandomColour(): void =
    let bgColours = [bgBlack, bgRed, bgGreen, bgYellow, bgBlue, bgMagenta, bgCyan]
    let bgColour = sample(bgColours)
    if bgColour != bgBlack:
        setForegroundColor(fgBlack)
    setBackgroundColor(bgColour)

proc main(): void =

    if paramCount() != 2:
        setBackgroundColor(bgRed)
        setForegroundColor(fgBlack)
        stdout.write("Usage: wordchains.bin <path to dictionary> <path to test file>")
        stdout.write("\nExample: ./wordchains.bin 50kwords.txt word-pairs-simple.txt")
        resetAttributes()
        echo ""
        quit()

    randomize()
    loadDictionary(paramStr(1))

    for line in lines paramStr(2):
        var seperated = line.split(' ')
    
        if(validPair(seperated[0], seperated[1])):
            globalStack = @[]
            var result = findChain(seperated[0], seperated[1])
    
            var counter = 0
            setRandomColour()
            stdout.write(seperated[0])
            stdout.write("->")
            resetAttributes()
            for word in result:
                setRandomColour()
                stdout.write(word)
                if counter < result.len - 1:
                    stdout.write("->")
                resetAttributes()
                counter = counter + 1
    
            echo ""

main()