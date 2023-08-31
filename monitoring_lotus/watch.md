# Combining Multiple `watch` Commands in a Single `tmux` Window

## Table of Contents

- [Prerequisites](#prerequisites)
- [Steps](#steps)
- [Automation Script](#automation-script)
- [Recommendations](#recommendations)
- [Installing `watch` on macOS](#installing-watch-on-macos)
- [Installing `watch` on Windows](#installing-watch-on-windows)

## Prerequisites

Ensure you have `tmux` installed on your system. If you don't have it, you can install it using your package manager. For Ubuntu:

```bash
sudo apt-get install tmux
```

## Steps

1. **Start a new \`tmux\` session**:

```bash
tmux
```

2. **Split the window into multiple panes**:
    - Split vertically: `Ctrl-b %`
    - Split horizontally: `Ctrl-b "`
    
    Adjust the number of splits based on the number of commands you want to run.

3. **Navigate between panes** using \`Ctrl-b\` followed by the arrow key in the direction you want to move.

4. **Run your \`watch\` commands** in each pane.

5. **Detach and Reattach**:
    - Detach: \`Ctrl-b\` followed by \`d\`
    - Reattach:

        ```bash
        tmux attach
        ```

## Automation Script

For convenience, here's a script that automates the above steps:

```bash
#!/bin/bash
```

# Start a new tmux session in detached mode

```bash
tmux new-session -d -s mywatch
```

# Split the window into multiple panes
```bash
tmux split-window -v
tmux split-window -v
tmux split-window -v
tmux split-window -v
tmux split-window -v
tmux split-window -v
tmux select-pane -t 0
tmux split-window -h
```

## Run the watch commands in each pane

```bash
tmux send-keys -t 0 'watch -n 10 -c "lotus-miner --color info"' C-m
tmux send-keys -t 1 'watch -n 1 -c "lotus-miner --color proving info"' C-m
tmux send-keys -t 2 'watch -n 1 -c "lotus-miner --color actor control list"' C-m
tmux send-keys -t 3 'watch -n 1 -c "lotus-miner sealing jobs"' C-m
tmux send-keys -t 4 'watch -n 1 -c "lotus-miner --color sealing workers"' C-m
tmux send-keys -t 5 'watch -n 1 -c "lotus-miner --color proving workers"' C-m
tmux send-keys -t 6 'watch -n 300 -c "lotus-miner --color storage list"' C-m
tmux send-keys -t 7 'watch -n 1 "lotus net bandwidth; lotus net peers | wc -l"' C-m
```

# Attach to the tmux session

```bash
tmux attach -t mywatch
```

## Recommendations

For macOS and Windows users, we recommend the following terminals:

- [NoMachine](https://www.nomachine.com/)
- [Warp](https://www.warp.dev/)

## Installing \`watch\` on macOS

For macOS users, you can easily install \`watch\` using Homebrew. If you don't have Homebrew installed, you can get it from [here](https://brew.sh/). Once you have Homebrew:

```bash
brew install watch
```

## Installing \`watch\` on Windows

For Windows users, the process is a bit more involved. We recommend using the Windows Subsystem for Linux (WSL). Here's a brief guide:

1. Install [WSL](https://docs.microsoft.com/en-us/windows/wsl/install).
2. Once WSL is set up, open your Linux distribution (e.g., Ubuntu).
3. Update your package list:

```bash
sudo apt update
```

4. Install `watch`:

```bash
sudo apt install procps
```

Now, you can use `watch` within your WSL terminal.