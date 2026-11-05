function claude-tweaks --description 'Start Claude Desktop with layout tweaks'
    set -l dir ~/.config/claude-tweaks
    set -l port 19333
    set -q CLAUDE_TWEAKS_PORT; and set port $CLAUDE_TWEAKS_PORT

    switch "$argv[1]"
        case open list
            CLAUDE_TWEAKS_PORT=$port python3 $dir/inject.py --$argv[1]
            return
    end

    # Official package: claude-desktop. Community build: claude-desktop-unofficial.
    set -l bin $CLAUDE_TWEAKS_BIN
    if test -z "$bin"
        for c in claude-desktop claude-desktop-unofficial
            if type -q $c
                set bin $c
                break
            end
        end
    end
    if test -z "$bin"
        echo "Can't find Claude Desktop. Set CLAUDE_TWEAKS_BIN to the command that starts it." >&2
        return 1
    end

    set -l up "http://127.0.0.1:$port/json/version"
    if not curl -fs $up >/dev/null
        # Claude only reads launch flags at startup, so close a running copy first.
        # Its lock file names the main process as <hostname>-<pid>.
        set -l cfg ~/.config
        set -q XDG_CONFIG_HOME; and set cfg $XDG_CONFIG_HOME
        set -l lock $cfg/Claude/SingletonLock
        if test -L $lock
            set -l pid (string split -r -m1 -- - (readlink $lock))[-1]
            # The lock can be stale, so make sure the PID still belongs to Claude.
            if string match -qr '^\d+$' -- "$pid"; and string match -qi '*claude*' -- (readlink /proc/$pid/exe 2>/dev/null) (cat /proc/$pid/cmdline 2>/dev/null | string split0)
                kill $pid
                for i in (seq 50)
                    test -e /proc/$pid; or break
                    sleep 0.2
                end
            end
        end
        setsid -f $bin --remote-debugging-port=$port >/dev/null 2>&1
        for i in (seq 75)
            curl -fs $up >/dev/null; and break
            sleep 0.2
        end
        if not curl -fs $up >/dev/null
            echo "Claude didn't open port $port. Quit it fully (tray icon > Quit) and try again." >&2
            echo "If it wasn't running, set CLAUDE_TWEAKS_BIN to Claude's actual binary." >&2
            return 1
        end
    end

    pkill -f "$dir/inject.py\$" 2>/dev/null # replace an injector from an earlier run
    CLAUDE_TWEAKS_PORT=$port setsid -f python3 $dir/inject.py >$dir/inject.log 2>&1
    echo "Ready. Press Ctrl+Alt+U in Claude to open the layout panel."
end
