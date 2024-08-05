function say(txt)
    SendPacket(2,"action|input\ntext|"..txt)
end

say("ACTIVE")
