These instructions apply to version 1.99 and later

**Table of contents:**
* [Installation](#installation)
* [Running it](#running-it)
* [Troubleshooting and changes](#troubleshooting-and-changes)


# Installation #

  * Decompress and untar the Biodiverse package file to your hard drive.  The following assumes you have unzipped it so `$HOME/biodiverse` is the top level.  If you use a different path then modify the commands as appropriate.
  * You might need to also install some of the dependencies, depending on your Linux installation.  See the [InstallationLinuxSource](InstallationLinuxSource) page for details (the lines containing apt-get).

```
  sudo apt-get update

  # now get the apts
  # for XML::Parser
  sudo apt-get install libexpat1-dev
  #  For online docs
  sudo apt-get install libssl-dev
  #  Gtk:
  sudo apt-get install libcairo2-dev libpango1.0-dev libgtk2.0-dev libgnomecanvas2-dev
  
  #  GDAL:
  #  we build our own gdal for the source code version, 
  #  but for the binary version the apt-get version seems to work.
  #  next two commands from http://www.sarasafavi.com/installing-gdalogr-on-ubuntu.html
  sudo add-apt-repository ppa:ubuntugis/ppa && sudo apt-get update
  sudo apt-get install gdal-bin
  sudo apt-get install libkml-dev libfreexl-dev libogdi3.2-dev

```

# Running it #

  * Biodiverse can be run by double clicking on `BiodiverseGUI_linux`.
  * If you want to keep the command log visible after you close Biodiverse then run it from a terminal.
    * In the terminal, type `$HOME/biodiverse/BiodiverseGUI_linux`.
  * If you want to avoid all the typing then edit your profile to add the biodiverse directory to your $PATH environment variable.

# Troubleshooting and changes #

  * Ensure that you have installed the latest `GTK+`, `Glade` and `GnomeCanvas` packages.

  * If you don't like the current window theme then you can change them using the Desktop Preferences (also via the `gnome-appearance-properties` tool).  You can download and install more themes from http://art.gnome.org/themes/gtk2

  * Please report any other issues using the [project issue tracker](https://github.com/shawnlaffan/biodiverse/issues/)