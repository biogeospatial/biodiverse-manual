**These instructions apply to version 2.0 and later.**

# Installation #

  * These instructions assume you have [downloaded](https://purl.org/biodiverse/wiki/downloads) and extracted the Biodiverse zip file to your hard drive.
  * The following assumes you have unzipped it to `C:\biodiverse`.  If you use a different path then modify the commands below as appropriate.

# Running it #

  * Biodiverse can be run by double clicking on `C:\biodiverse\BiodiverseGUI.exe`.
    * Do not use the `BiodiverseGUI.bat` file.  It is used for the source code version.
  * If you want to keep the command log visible after you close Biodiverse then run it from a command prompt.
    * Under `Start Menu -> Run` type `cmd`.
    * In the resulting command window, type `C:\biodiverse\BiodiverseGUI.exe`.


# Troubleshooting and changes #

  * Slow first startup
    * The Windows executable is generated using the [pp tool](https://metacpan.org/pod/pp).  The files are unpacked to the temp folder at first use, so starting the first time takes a minute or two.  
    * Tools that clean the temp folder will erase the extracted files, in which case they will need to be re-extracted.

  * Please report any other issues using the [project issue tracker](https://github.com/shawnlaffan/biodiverse/issues/)