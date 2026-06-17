These instructions apply to version 2.99_001 and later.

These assume you have saved the Biodiverse source code to C:\biodiverse.  If you have not then change the `C:\biodiverse\lib` path in the following to the appropriate path.

_IMPORTANT_:  You need to be sure to run step 4 from the installation every time you want to run the system.  (This is until we develop a batch script to handle it).

_DO NOT USE A PATH WITH SPACES IN IT_.  This causes problems with the batch file used to run the source code version.  (This has no effect on the executable file).


# StrawberryPerl #


## Installation ##


*  Step 1.  Install [Strawberry Perl 5.38 PDL edition](https://github.com/StrawberryPerl/Perl-Dist-Strawberry/releases/download/SP_5380_5361/strawberry-perl-5.38.0.1-64bit-PDL.zip).  The rest of these instructions assume you have extracted it to C:\strawberry.  If you have not then edit the paths below to match what you have used.  

*  Step 2.  [Download](Downloads) the source code version to obtain a stable release.  Alternately you can use a git client to get the latest Biodiverse code, see https://github.com/shawnlaffan/biodiverse and the clone URL there.

*  Step 3.  Open a command prompt.  The rest of these instructions assume you are at the prompt.

*  Step 4.  Run these commands, editing the folder paths as needed to match your system.

```cmd
  set BDV_PATH=c:\biodiverse
  set STRAWPATH=c:\strawberry
  :: This next command should only be needed if the strawberry perl bin folders 
  :: are not in your path already, or if Rtools (or some other c-compiler toolset) 
  :: comes before the strawberry perl bin folders in the path.
  set PATH=%STRAWPATH%\bin;%STRAWPATH%\perl\site\bin;%STRAWPATH%\perl\vendor\bin;%STRAWPATH%\perl\bin;%PATH%
```

*  Step 5.  Now we need to install some files using the ppm and cpanm utilities.  In the same command prompt that you ran the commands from step 1, run the ppm install command for all ppd files.  You can copy and paste these into the command prompt.  It is best to do them one block at a time as the comments list some conditional steps.  

```cmd
  :: Install the precompiled binaries needed for the GUI.
  cpanm https://github.com/shawnlaffan/perl-alien-gtkstack-windows.git
  ppm set repository biodiverse https://github.com/shawnlaffan/perl-alien-gtkstack-windows/releases/download/first_upload/
  ppm install Cairo
  ppm install Cairo-GObject
  ppm install Glib
  ppm install Gnome2-Canvas
  ppm install Gtk2
  ppm install Pango
  
  ::  This might no longer be necessary, but does not hurt.  
  ::  Math::Random::MT::Auto had test errors due to 
  ::  false positive test results caused by another module.
  cpanm Math::Random::MT::Auto
  :: If the tests report failures due 
  :: to a missing signal then force install it.
  :: (But not for other failures).
  cpanm --notest Math::Random::MT::Auto

  :: Faster utils, don't worry if the installs fail (possible for Data::Recursive)
  cpanm List::MoreUtils::XS
  cpanm https://github.com/shawnlaffan/biodiverse-utils/releases/download/v1.09/Biodiverse-Utils-1.09.tar.gz
  cpanm Data::Recursive

  :: Now install the rest of the dependencies.  
  :: Ensure you are within the main Biodiverse directory 
  :: when running it, as it needs to find the file called `cpanfile`
  :: Note that the GDAL installation can take a _loooong_ time (>40 minutes)
  cpanm --installdeps .

  :: The next line is only needed for v3.1 and earlier.
  :: You might need to re-run it a few times as 
  :: anti-virus scanning can cause test failures due to 
  :: file locks not being released.
  cpanm Task::Biodiverse

```


## Running it ##

The above installation process **should** install all the relevant files, so we can now run it.

*  This is the same as step 1 in the installation instructions, but needs to be run every time you open a new command prompt (unless you add the paths to your PATH variable at the windows level).  Remember to edit the folder paths if you installed Biodiverse and/or Strawberry Perl to different folders.

```cmd
  set BDV_PATH=c:\biodiverse
  set STRAWPATH=c:\strawberry
  set PATH=%STRAWPATH%\bin;%STRAWPATH%\perl\site\bin;%STRAWPATH%\perl\vendor\bin;%STRAWPATH%\perl\bin;%BDV_PATH%\bin;%PATH%
  ::  If you are using Biodiverse 4.99_001 or earlier then you need to add one module to the default set, otherwise this can be skipped.
  set PERL5OPT=-MAlien::GtkStack::Windows 
```

*  Now you can run it.

```cmd
  perl %BDV_PATH%\bin\BiodiverseGUI.pl
```


  * See the [trouble shooting](#trouble-shooting) section below if you encounter problems, for example modules failing to load.


# Trouble shooting #

  * If Perl complains that it cannot locate a file when running Biodiverse then this library will need to be installed interactively using cpan. The complaint will contain text like `Can't locate Fred/Fred.pm in @INC (@INC contains:...)`  In this case, install module Fred::Fred (substitute a double colon "::" for each forward slash "/", and remove the trailing ".pm" from the module it cannot locate). E.g.: `cpanm Fred::Fred` . This can happen if one or more of the modules listed in the Task distributions failed to install.

  * Please report any other issues using the [project issue tracker](https://github.com/shawnlaffan/biodiverse/issues/)