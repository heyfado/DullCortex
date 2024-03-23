## "A quick way to fix Razer Synapse"

Hello, <br />
This is a quick script I threw together to remove the Razer Game Manager (& Service) from my computer. <br />
It deletes the folder & files, and removes the registry entries. <br />
It then patches the registry key dependency baked in to Razer Synapse. <br />
*** IT THEN WILL RESTART THE SYSTEM! *** <br />
This program requires being run as administrator, and is supposed to trigger a UAC prompt ("run as administrator") when launched.

Code is simple, commented, and *decently* readable, feel free to tweak it on your own, or suggest changes here! <br />
Excuse the dumb parody name, as I forgot Razer already had a product called Razer Cortex. <br />
-fado

*** If Synapse runs but the window does not "open", try opening Razer Central Service first from the tray in the Windows task bar ***
