To install Biodiverse from source for macOS four broad steps are required. First, if you haven't already, you will have to install Xcode command line tools. Second, a software management system has to be installed which can be used to install software required by Biodiverse. Third, Biodiverse requires a higher version of perl than that installed by default on macOS. This and Biodiverse's perl modules dependancies will be install. Fourth, Biodiverse will be installed.

If you find issues with these instructions then please raise an [issue](https://github.com/shawnlaffan/biodiverse/issues/) or start a [discussion thread](https://github.com/shawnlaffan/biodiverse/discussions).

# Install Xcode command line tools
To install Xcode command line tools (and all following software) you will be using the Terminal application. To open Terminal:

1. Double-click the Terminal application in the Applications:Utilities folder. Or do a Spotlight search for "Terminal" and open it.

2. Copy and paste the below text at the terminal prompt and then hit return.
   ```sh
    xcode-select --install
   ```

3. Once this is install you will need to agree the Apple's software licence.
   ```sh
   sudo xcodebuild -license
   ```
   Enter your password when prompted.

# Installing Homebrew and required software.

1. Homebrew is a package management system which simplifies the installation of software on Apple's macOS operating system. It is used to install software required by Biodiverse.
   ```sh
   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
   ```
2. Install other required packages:
   ```sh
   brew install gdk-pixbuf pango gtk+ gtk+3 libglade libffi gdal openssl
   brew install hicolor-icon-theme
   brew install adwaita-icon-theme
   ```


Further information about Homebrew can be found [here](https://brew.sh).

# Installing perlbrew and required perl modules
perlbrew is an admin-free perl installation management tool. It can be used to install a version of perl that Biodiverse requires. 
1. Copy and paste this line into your terminal to install perlbrew:
   ```sh
   \curl -L https://install.perlbrew.pl | bash
   ```
2. Install the version of perl that Biodiverse requires and then use it (must be at least 5.36):
   ```sh
   ~/perl5/perlbrew/bin/perlbrew install --noman perl-5.36.1
   #  if there are "no symbol" test failures in libperl.t then skip the tests
   #~/perl5/perlbrew/bin/perlbrew install --noman --notest perl-5.36.1
   ~/perl5/perlbrew/bin/perlbrew switch perl-5.36.0
   ```
3. Install cpanminus for installing other perl modules:
   ```sh
   perlbrew install-cpanm
   ```
4. Install Biodiverse GUI  module dependencies.  Gtk2 has known test failures, but works, so we don't test it.
   ```sh
   cpanm --notest Gtk2
   cpanm Pango IO::Socket::SSL Glib::Object::Introspection Scalar::Util::Numeric Browser::Start
   ```
5. Install libgnomecanvas dynamic lib and perl module, including a patch to avoid a serious memory leak.  These have not been widely tested so please report issues. 
   ```sh
    cpanm XML::Parser 
    brew install libart intltool gettext
    \curl -L https://download.gnome.org/sources/libgnomecanvas/2.30/libgnomecanvas-2.30.3.tar.bz2 > libgnomecanvas-2.30.3.tar.bz
    tar xf libgnomecanvas-2.30.3.tar.bz
    cd libgnomecanvas-2.30.3
    \curl -L https://raw.githubusercontent.com/shawnlaffan/biodiverse/master/etc/libgnomecanvas.patch > libgnomecanvas.patch
    patch -d libgnomecanvas < libgnomecanvas.patch
    #  if you are willing to take the risk then you can install into --prefix=$HOMEBREW_PATH
    ./configure --disable-dependency-tracking --disable-static --prefix=$HOME/usr --disable-glade
    make
    make install
    export DYLD_LIBRARY_PATH=${HOME}/usr:${DYLD_LIBRARY_PATH}
    export CPATH=${HOME}/usr:${CPATH}
    cpanm --notest Gnome2::Canvas
    ```

# Install Biodiverse

1. Install Biodiverse either from source or by cloning the git repository. If using git then to install at the top level of your home directory:
    ```sh
    cd ~
    git clone --depth 1 https://github.com/shawnlaffan/biodiverse.git
    cd biodiverse
    cpanm --installdeps .
    #  only need to run these two lines for v3.1 or earlier
    cpanm Task::Biodiverse::NoGUI
    cpanm Task::Biodiverse

    # Some utility functions that make processing faster. These are not critical so ignore them if there are installation errors.  
    # The first one might need an update to cpanm for it to access the file.
    cpanm LWP::Protocol::https
    cpanm https://github.com/shawnlaffan/biodiverse-utils/releases/download/v1.11/Biodiverse-Utils-1.11.tar.gz
    cpanm Data::Recursive


    #  make sure the file history can be saved
    mkdir -p ${HOME}/.local/share/
    touch $HOME/recently-used.xbel  
    ```

2. To run biodiverse switch to the correct version of perl if you haven't already (this assumes perl-5.36.1), and then run biodiverse.  The DYLD_LIBRARY_PATH is something you an add to your .zshrc or .bashrc file to avoid retyping it.
    ```sh
    export DYLD_LIBRARY_PATH=${HOME}/usr:${DYLD_LIBRARY_PATH}
    ~/perl5/perlbrew/bin/perlbrew switch perl-5.36.1
    perl ~/biodiverse/bin/BiodiverseGUI.pl
    ```

Back to the [main installation page.](https://github.com/shawnlaffan/biodiverse/wiki/Installation)
