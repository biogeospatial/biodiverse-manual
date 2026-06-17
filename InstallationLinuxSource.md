These instructions apply to version 2.99_001 and later.

Note that they have been tested on Ubuntu 16.  The package manager will differ for other Linux flavours, but the cpan command will be the same.

These also assume you have [downloaded](https://github.com/shawnlaffan/biodiverse/wiki/Downloads) the Biodiverse source code to your home directory and renamed it from whatever it was, e.g. `biodiverse_4.99_source`, to `biodiverse`.  If you have saved it somewhere else then you will need to adjust the following so any references to `$HOME/biodiverse/lib` use the appropriate directory.

**Table of contents:**
* [Installation](#installation)
* [Running it](#running-it)
* [Troubleshooting](#troubleshooting)


# Installation #

  * This will require some interaction when it downloads additional packages, depending on your CPAN settings.

  * **Do not use the system perl for this**.  The operating system assumes specific versions of files are in the system perl.  Perlbrew is recommended, and is used for Biodiverse development, and is assumed below.  https://perlbrew.pl/

  * Once you have installed the non-system perl, you need to make sure it is the one you call in subsequent steps.  You will probably need to give the full path name to the perl binary when used below, rather than just saying `perl`.


```bash
  sudo apt-get update

  # now get the apts
  # for XML::Parser
  sudo apt-get install libexpat1-dev
  #  For online docs
  sudo apt-get install libssl-dev
  #  Gtk:
  sudo apt install libcairo2-dev libpango1.0-dev libgtk2.0-dev libgnomecanvas2-dev
  sudo apt install libcanberra-gtk-module
  # GDAL deps:
  sudo apt install sqlite3 libgdal-dev

  ##  Skip this step if you already have cpanm installed
  ##  Uncomment and use this next line if you are not using perlbrew
  # wget -O - https://cpanmin.us | perl - App::cpanminus
  ##  but if you are using perlbrew:
  perlbrew install-cpanm

  ## Now install (most of) the rest of the dependencies
  ##  Assuming you have unpacked or git cloned the files to ~/biodiverse
  cd ~/biodiverse
  cpanm --installdeps .

  #  These are needed for the GUI
  #  Gtk2 has test failures that do not affect Biodiverse
  #  so we skip its tests.
  cpanm --notest Gtk2
  cpanm Gnome2::Canvas
  cpanm HTTP::Tiny
  cpanm Browser::Start
  cpanm IO::Socket::SSL

  ## If you are using Biodiverse 3.1 or earlier
  cpanm Task::Biodiverse::NoGUI
  cpanm Task::Biodiverse

  ## some libs to make Biodiverse go faster if present
  ## but don't worry if they do not install cleanly, the system will work without them.
  ## Panda::Lib does not install on Windows so is not in the dep list
  ## cpanm Panda::Lib
  cpanm Data::Recursive
  ##  Biodiverse::Utils is not yet on cpan
  cpanm https://github.com/shawnlaffan/biodiverse-utils/releases/download/v1.11/Biodiverse-Utils-1.11.tar.gz
  

```

If you don't like the current window theme then there are various tools you can install to change it.


# Running it #

  * To run Biodiverse, open a terminal window and change directory to the biodiverse/bin folder.  If it is in your home folder and called `biodiverse` then type:
```bash
cd ~/biodiverse/bin
```
  * Once you have done this, type the following command to open Biodiverse.
```bash
perl BiodiverseGUI.pl
```
  * Alternately, you could give the full path to Biodiverse if you want to start in a particular directory (i.e. where all your files are).
```bash
perl ~/biodiverse/bin/BiodiverseGUI.pl
```
  * If you want your command prompt back after opening Biodiverse then run it as a background job.  However, the log output will then be mixed with any other commands you type.
```bash
perl BiodiverseGUI.pl &
```


  * You can also add the `biodiverse/bin` folder to your PATH variable to save some typing. You might also need to edit the shebang line in BiodiverseGUI.pl to point to the correct perl executable.

# Troubleshooting #
  * Ubuntu 11 appears to need this before running the other installer commands:  `sudo apt-get install libgnome2-canvas-perl`
  * Please report any issues using the [project issue tracker](https://github.com/shawnlaffan/biodiverse/issues/)