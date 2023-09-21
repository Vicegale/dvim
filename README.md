# What is it?

Dockerified VIM!

I dockerified @ThePrimeagen's nvim config (with minor changes), to pull it into dev
servers and get nvim code auto-completion without any setup.

It can also be useful for people to try a config without any effort.

# Setup

Put dvim into your $PATH.

## Why? 

All dvim does is run `docker run`. It will share your current directory with 
the container and run the bash command.

If you don't have the image yet, docker will pull it for you. Hence,
no other setup is required.

# Run

```
cd my-project
dvim
```

This launches the container and puts you in its shell. Then, just `nvim` or
`nvim .` as usual
