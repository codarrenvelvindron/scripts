#!/usr/bin/env bash
install(){
dir="$HOME/openssl111"
tempdir="$HOME/Downloads/openssl1.1.1_source_files"
archive="$tempdir/openssl-1.1.1-pre2"
libraries="$dir/lib/"
bin="$dir/bin/openssl"
: '
echo "!!!1.Creating temp directories!!!"
sudo mkdir -p $tempdir
sudo mkdir -p $dir
echo "Install directory: $dir"
echo "Temporary directory: $tempdir"
cd $tempdir && sudo wget https://www.openssl.org/source/openssl-1.1.1-pre2.tar.gz
echo "!!!2.Goto Tempdir and 3.Downloading setup!!!"
echo "!!!4.Extracting files!!!"
cd $tempdir && sudo tar -xvzf openssl-1.1.1-pre2.tar.gz
echo "!!!5.Opening install dir!!!"
echo "!!!6.Setting compilation flags!!!"
echo "Home Directory: $HOME"
echo "Openssl install path: $dir"
echo "!!!7.Configure!!!"
cd $archive && sudo ./config --prefix="$dir" --openssldir="$dir" enable-tls1_3 && sudo make && sudo make install
echo "!!!8.Make Done!!!"
echo "!!!9.Make install Done!!!"
echo "!!!10.Link libraries!!!"
echo "export LD_LIBRARY_PATH=$libraries"
export LD_LIBRARY_PATH=$libraries
'
echo "Your OpenSSL 1.1.1 pre2 is installed in $dir"
}
install
