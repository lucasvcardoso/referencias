﻿ Get-WmiObject Win32_process -filter 'name = "MSBuild.exe"' | foreach-object { $_.SetPriority(256) }
 Get-WmiObject Win32_process -filter 'name = "devenv.exe"' | foreach-object { $_.SetPriority(256) }
 Get-WmiObject Win32_process -filter 'name = "node.exe"' | foreach-object { $_.SetPriority(256) }
 Get-WmiObject Win32_process -filter 'name = "firefox.exe"' | foreach-object { $_.SetPriority(256) }
 Get-WmiObject Win32_process -filter 'name = "iisexpress.exe"' | foreach-object { $_.SetPriority(256) }
 Get-WmiObject Win32_process -filter 'name = "iisexpresstray.exe"' | foreach-object { $_.SetPriority(256) }