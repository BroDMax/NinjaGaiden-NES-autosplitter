state("fceux")
{
    byte nextlevel: 0x3B1388, 0x01FD;
    byte time:      0x3B1388, 0x0063;
    ushort level:   0x3B1388, 0x006D;
    byte start1:    0x3B1388, 0x0033;
    byte start2:    0x3B1388, 0x004C;
    int reset:      0x3B1388, 0x00F0;
}

state("nestopia")
{
    byte nextlevel: "nestopia.exe", 0x1b2bcc, 0, 8, 0xc, 0xc, 0x265;
    byte time:      "nestopia.exe", 0x1b2bcc, 0, 8, 0xc, 0xc, 0xCB;
    ushort level:   "nestopia.exe", 0x1b2bcc, 0, 8, 0xc, 0xc, 0xD5;
    byte start1:    "nestopia.exe", 0x1b2bcc, 0, 8, 0xc, 0xc, 0x9B;
    byte start2:    "nestopia.exe", 0x1b2bcc, 0, 8, 0xc, 0xc, 0xB4;
    int reset:      "nestopia.exe", 0x1b2bcc, 0, 8, 0xc, 0xc, 0x158;
}

state("mednafen")
{
    byte nextlevel: "mednafen.exe", 0xBE1EDD;
    byte time:      "mednafen.exe", 0xBE1D43;
    ushort level:   "mednafen.exe", 0xBE1D4D;
    byte start1:    "mednafen.exe", 0xBE1D13;
    byte start2:    "mednafen.exe", 0xBE1D2C;
    int reset:      "mednafen.exe", 0xBE1DD0;
}

init
{
    vars.maxlevel = 0;
}

startup
{
    
    settings.Add("stg11", false, "Stage 1-1");
    settings.Add("stg12", true, "Stage 1-2");
    settings.Add("stg21", false, "Stage 2-1");
    settings.Add("stg22", false, "Stage 2-2");
    settings.Add("stg23", true, "Stage 2-3");
    settings.Add("stg31", false, "Stage 3-1");
    settings.Add("stg32", false, "Stage 3-2");
    settings.Add("stg33", true, "Stage 3-3");
    settings.Add("stg41", false, "Stage 4-1");
    settings.Add("stg42", false, "Stage 4-2");
    settings.Add("stg43", false, "Stage 4-3");
    settings.Add("stg44", true, "Stage 4-4");
    settings.Add("stg51", false, "Stage 5-1");
    settings.Add("stg52", false, "Stage 5-2");
    settings.Add("stg53", false, "Stage 5-3");
    settings.Add("stg54", true, "Stage 5-4");
    settings.Add("stg61", false, "Stage 6-1");
    settings.Add("stg62", false, "Stage 6-2");
    settings.Add("stg63", false, "Stage 6-3");
    settings.Add("boss1", false, "Stage 6-4 (Boss 1)");
    settings.Add("boss2", false, "Stage 6-4 (Boss 2)");
    settings.Add("boss3", true, "Stage 6-5 (Final boss)");
    
    vars.maxlevel = 0;
}

split
{
    if ((current.time == 0) && ((old.nextlevel == 0xD5) && (current.nextlevel == 0xD6)))
    {
        switch((ushort)current.level)
        {
            case 0x0101:
                if (settings["stg12"]) return true;
                break;
            case 0x0904:
                if (settings["stg23"]) return true;
                break;
            case 0x0C07:
                if (settings["stg33"]) return true;
                break;
            case 0x150B:
                if (settings["stg44"]) return true;
                break;
            case 0x220F:
                if (settings["stg54"]) return true;
                break;
            case 0x2D13:
                if (settings["boss1"]) return true;
                break;
            case 0x2E14:
                if (settings["boss2"]) return true;
                break;
            case 0x2F15:
                if (settings["boss3"]) return true;
                break;
        }
    }
    
    if (vars.maxlevel < current.level)
    {
        vars.maxlevel = current.level;
        
        switch((ushort)current.level)
        {
            case 0x0101:
                if (settings["stg11"]) return true;
                break;
            case 0x0603:
                if (settings["stg21"]) return true;
                break;
            case 0x0904:
                if (settings["stg22"]) return true;
                break;
            case 0x0B06:
                if (settings["stg31"]) return true;
                break;
            case 0x0C07:
                if (settings["stg32"]) return true;
                break;
            case 0x1009:
                if (settings["stg41"]) return true;
                break;
            case 0x110A:
                if (settings["stg42"]) return true;
                break;
            case 0x150B:
                if (settings["stg43"]) return true;
                break;
            case 0x170D:
                if (settings["stg51"]) return true;
                break;
            case 0x1B0E:
                if (settings["stg52"]) return true;
                break;
            case 0x220F:
                if (settings["stg53"]) return true;
                break;
            case 0x2411:
                if (settings["stg61"]) return true;
                break;
            case 0x2912:
                if (settings["stg62"]) return true;
                break;
            case 0x2D13:
                if (settings["stg63"]) return true;
                break;
        }
    }
}

reset
{
    if (current.reset == 0x00)
    {
        vars.maxlevel = 0;
        return true;
    }
}

start
{
    vars.maxlevel = current.level;
    return ((old.start1 == 0x00) && (current.start1 == 0x97)
    && (old.start2 == 0x40) && (current.start2 == 0x00));
}
