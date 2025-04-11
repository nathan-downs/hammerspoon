-- Load the IPC module
hs.ipc.cliInstall()

function resetMonitorBrightness()
    -- Get the full path to m1ddc
    local m1ddcPath = "/opt/homebrew/bin/m1ddc"
    
    -- Check if the file exists
    local file = io.open(m1ddcPath, "r")
    if file then
        file:close()
        hs.notify.new({title="Monitor Brightness", informativeText="Setting brightness..."}):send()
        
        -- Use hs.task for better command execution
        local task = hs.task.new(m1ddcPath, 
            function(exitCode, stdOut, stdErr)
                if exitCode == 0 then
                    hs.notify.new({title="Monitor Brightness", informativeText="Successfully set to 100%"}):send()
                else
                    hs.notify.new({title="Error Setting Brightness", 
                                  informativeText="Exit code: " .. exitCode .. "\nError: " .. (stdErr or "none")}):send()
                end
            end, 
            {"display", "2", "set", "luminance", "100"}
        )
        task:start()
    else
        hs.notify.new({title="Error", informativeText="m1ddc not found at " .. m1ddcPath}):send()
    end
end

-- Watch for screen changes
screenWatcher = hs.screen.watcher.new(function()
    -- Add a delay to ensure the monitor is fully initialized
    hs.timer.doAfter(3, resetMonitorBrightness)
end)
screenWatcher:start()

-- Also reset on startup with a delay
hs.timer.doAfter(5, resetMonitorBrightness)

-- Print a message to the console to confirm loading
print("Hammerspoon config loaded!")
