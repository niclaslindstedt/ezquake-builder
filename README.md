# ezquake-builder

Build your ezQuake binaries for Windows/Linux using only Docker (Linux-based).

## Compiling

Use the commands below to compile ezQuake. The resulting binary will be placed in the current directory if none is given (as second argument, after platform).

### Windows

```
curl -sL https://raw.githubusercontent.com/niclaslindstedt/ezquake-builder/master/compile.sh | sh -s windows
```

### Ubuntu 20.04 "Focal Fossa"

```
curl -sL https://raw.githubusercontent.com/niclaslindstedt/ezquake-builder/master/compile.sh | sh -s ubuntu20.04
```

### Ubuntu 18.04 "Bionic Beaver"

```
curl -sL https://raw.githubusercontent.com/niclaslindstedt/ezquake-builder/master/compile.sh | sh -s ubuntu18.04
```

### Debian 10 "Buster"

```
curl -sL https://raw.githubusercontent.com/niclaslindstedt/ezquake-builder/master/compile.sh | sh -s debian10
```

### Debian 9 "Stretch"

```
curl -sL https://raw.githubusercontent.com/niclaslindstedt/ezquake-builder/master/compile.sh | sh -s debian9
```

### Fedora 25+

```
curl -sL https://raw.githubusercontent.com/niclaslindstedt/ezquake-builder/master/compile.sh | sh -s fedora25
```

## Compiling a specific ezQuake branch

Just add a branch argument at the end to compile a specific branch.

```
curl -sL https://raw.githubusercontent.com/niclaslindstedt/ezquake-builder/master/compile.sh | sh -s windows [branch]
```

## Compiling using local sources

If you have a source folder locally that you wish to compile:

```
./compile-local.sh <local folder> <platform> [output folder]
```

## Troubleshooting

Run `dos2unix` on all `*.sh` files if there are any problems.
