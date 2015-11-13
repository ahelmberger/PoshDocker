# PoshDocker

Powershell utils for working with Docker on Windows

## Features

* Setup your shell environment for work with [Boot2Docker](http://boot2docker.io/) in a single command
* Stop the Boot2Docker virtual machine

The commands also check if the required binaries git and ssh are in your path.

### Installation

In your PowerShell console execute:

~~~Powershell
(new-object Net.WebClient).DownloadString("https://raw.githubusercontent.com/ahelmberger/PoshDocker/master/Install.ps1") | iex
~~~

You are done. This nice line of PowerShell script will download Install.ps1 and send it to Invoke-Expression to install the PoshDocker module.

Alternatively you can do installation manually

* Download PoshDocker.psm1 from https://github.com/ahelmberger/PoshDocker
* Copy PoshDocker.psm1 to your modules folder (e.g. Modules\PoshDocker\ )
* Execute Import-Module PoshDocker (or add this to your profile)
* Enjoy!

### Examples

~~~Powershell
# Start the VM from any state, set all necessary environment variables and output the current docker host IP address
Start-Boot2Docker

# Gracefully shutdown the VM
Stop-Boot2Docker
~~~
