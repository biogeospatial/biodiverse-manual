
# Building a dmg image
To build a dmg image for easy distribution of a binary version of Biodiverse follow the steps below.

1. Clone the Biodiverse git repository at the top level of you home directory if you haven't already:
   ```sh
   cd ~
   git clone https://github.com/shawnlaffan/biodiverse.git
   ```
2. Run the Biodiverse dmg creation script:
   ```sh
    perl ~/biodiverse/bin/mmb3.pl --verbose=1 --script ~/biodiverse/bin/BiodiverseGUI.pl -i ~/biodiverse/bin/Biodiverse_icon.ico --lib_path=/usr/local/opt/gdal-20/lib --lib_path=/usr/local/opt/liblwgeom/lib --lib_path=/usr/local/opt/libxml2/lib --lib_path=/usr/local/opt/sqlite/lib --lib_path=/usr/local/opt/readline/lib --lib_path=/usr/local/opt/icu4c/lib --lib_path=/usr/local/opt/openssl/lib --lib_path=/usr/local/opt/libffi/lib --lib_path=/usr/local/opt/gettext/lib --lib_path=/usr/local/lib
   ```
3. The dmg image can be found in ~/biodiverse/etc/mmb/builds.
