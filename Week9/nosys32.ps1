﻿Get-Process | where {$_.Path -inotlike "*system32*" } | Select-Object ProcessName, Path