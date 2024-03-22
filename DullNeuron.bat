:: DullNeuron - A Quick Way to 'Fix' Razer Synapse

:: ****THIS SCRIPT MUST BE RUN AS ADMINISTRATOR****

:: This will remove the Razer Game Manager files and folders from the system.
:: It will also remove the RGMS dependency from Razer Synapse, allowing it to be run without the Game Manager Installed.
:: *** THIS SCRIPT WILL HAVE TO BE RE-RUN WHENEVER SYNAPSE IS REINSTALLED OR UPDATES ***

:: ALWAYS INSTALL & RUN SYNAPSE AS A GUEST - DO NOT SIGN IN
:: Turn off recommendations in Synapse 3 Settings

:: I recommend ditching every razer module other than Synapse 3 and Chroma Studio (including removing other optional modules from Synapse 3, simply re-run the installer and choose the modify option to remove them)
:: If you have a hardened system, Razer Installer and Razer Update service will need network access, firewall rules, and possibly Defender/antivirus exclusions. 

:: Get admin rights (required to edit registry)
@echo off
if not "%1"=="am_admin" (
    powershell -Command "Start-Process -Verb RunAs -FilePath '%0' -ArgumentList 'am_admin'"
    exit /b
)

:: Stop all Razer Services (not all of these are necessary, but Razer may change their behavior in the future)
echo "Attempting to stop Razer Services"
taskkill /f /im "Razer Synapse.exe"
taskkill /f /im "Razer Synapse Service.exe"
taskkill /f /im "Razer Synapse Service Process.exe"
taskkill /f /im "Razer Synapse 3.exe"
taskkill /f /im "Synapse3.exe"
taskkill /f /im "Synapse3.exe"
taskkill /f /im "Razer Central.exe"
taskkill /f /im "RazerCentralService.exe"
taskkill /f /im "RazerCortex.exe
taskkill /f /im "RazerCortexService.exe"
taskkill /f /im "GameManagerService.exe"
taskkill /f /im "RzActionSvc.exe"
taskkill /f /im "RzChromaStreamServer.exe"
taskkill /f /im "RzDeviceEngine.exe"
taskkill /f /im "RzUpdateManager.exe"
:: As of right now I do not see a reason to kill ingame services, but I will leave this here for future reference

:: Wait for system to catch up:
TIMEOUT /T 1

:: Stop the Razer Game Manager Service
echo "Attempting to stop the Razer Game Manager Service"
NET STOP "Razer Game Manager Service"

:: Disable the Razer Game Manager Service in the Services Manager
echo "Attempting to disable the Razer Game Manager Service"
sc config <Razer Game Manager Service> start= disabled

:: How to stop (and remove) the RGMS service manually:
:: services.msc -> Razer Game Manager Service -> Right Click -> Properties -> Startup Type: Disabled -> Stop -> Apply -> OK

:: Remove the Razer Game Manager Folder and Files
echo "Attempting to remove Razer Game Manager Files and Folders"
rmdir /S /q "C:\ProgramData\Razer\Razer Game Manager"

:: Remove the Razer Game Manager Registry Entries
echo "Attempting to remove Razer Game Manager Registry Entries"
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Razer Game Manager Service" /f

:: Remove the Razer Game Manager Dependency from Razer Synapse
echo "Attempting to remove Razer Game Manager Dependency from Razer Synapse"
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Razer Synapse Service" /V "DependOnService" /f

:: How to remove the dependency manually:
:: HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Razer Synapse Service <- this is where the dependency is held, we want to remove that but keep Synapse
:: Remove "Razer Game Manager Service" from "DependendOnService" by double-clicking it and then removing that name

:: Wait for the system to catch up again:
TIMEOUT /T 1

:: You WILL need to restart your computer after this
:: (before reattempting to run Synapse)
:: Restart the Razer Synapse
echo "Attempting to restart Razer Synapse"
Start "" "C:\Program Files (x86)\Razer\Synapse3\WPFUI\Framework\Razer Synapse 3 Host\Razer Synapse 3.exe"

:: Restart the system
echo "############################################"
echo "############################################"
echo " FIX COMPLETE! "
echo "The system will now be restarted. There will be a delay!"
echo "############################################"
echo "############################################"
shutdown -r

:: I do not know why Synapse will seemingly only play nice again after a failed program start & a system restart, but it does.