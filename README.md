# future-haskell-demo

## Related presentation  

https://docs.google.com/presentation/d/1RuJ0BTenFBdTrBu4vvpAikTTrG5Fy4yWyLwGDm4pI44/edit?usp=sharing

## GHCi

```
λ> 2 + 2
λ> reverse "abrakadabra"
λ> take 20 . zipWith const [1..] $ drop 100 [1..]
```

## New project with stack

```
> stack new awesome-project
```

## Complie  

```
> stack build
```

## Apps  

### Hello world

```
> stack exec -- future-haskell-demo-hello
```

### Fibonacci

```
> stack exec -- future-haskell-demo-fib 10
```

### Fibonacci memoied

```
> stack exec -- future-haskell-demo-fib-memoized 1000
```
https://wiki.haskell.org/Memoization

### String replacements

```
> stack exec -- future-haskell-demo +RTS -s -RTS ./data/rewrite.txt ./data/in ./data/out
```

### String replacement threaded

```
> stack exec -- future-haskell-demo-threaded +RTS -s -N4 -RTS ./data/rewrite.txt ./data/in ./data/out
```

