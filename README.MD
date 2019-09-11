# Word Chain Challenge *NOT COMPLETE*

> But it works on my laptop!

## About

This was my attempt to do it in a new language (nim) in less than a day. It is not functional as it returns what looks like the longest possible path (which is the opposite of what its supposed to do). But hey, its an attempt.

## Compile
Download and install nim: [https://nim-lang.org](https://nim-lang.org).
Run 

```
nim -d:release --gcc.options.speed="-Ofast -flto-fno-strict-aliasing -ffast-math" --gcc.options.linker="-flto" c wordchains_tidy.nim
```

Or ignoring all logic and if wanting to compile this in a super unsafe way, yet providing insanely fast speeds (if I end up fixing this),

```
nim -d:release --gcc.options.speed="-Ofast -flto-fno-strict-aliasing -ffast-math" --gcc.options.linker="-flto" --objChecks="off" --fieldChecks="off" --rangeChecks="off" --boundChecks="off" --overflowChecks="off" --floatChecks="off" --nanChecks="off" --infChecks="off" --nilChecks="off" c wordchains_tidy.nim
```

This will turn off most of the runtime checks that are *definitely* not needed, squeezing out that extra millisecond.

## Running
To run the compiled binary,

```
./wordchains_tidy <path_to_dictionary> <path_to_test_file>
```

### Example
```
./wordchains_tidy 50kwords.txt word-pairs-simple.txt
```

## Design

This was not the original plan of what the algortihm wouldve looked like.
The plan was to hash the words and index them and use hashes to find the closest/next word.
Attempted to do that in Java with mixed results and got stuck on few parts.

## Innerworkings

Uses recursion to find the end of the chain.
Sequences are used as a primitive stack type to hold the word being processed and previous words.
This stack(sequence) can then be popped or reversed and printed out to the screen.

## NOT COMPLETE