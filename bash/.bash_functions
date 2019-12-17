# read a markdown files in terminal
mdr () {
    pandoc $1 | lynx --stdin
}
