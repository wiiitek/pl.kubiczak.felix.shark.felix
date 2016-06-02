
pl.kubiczak.felix.shark.felix
==============================

[![Build Status](https://travis-ci.org/wiiitek/pl.kubiczak.felix.shark.felix.svg?branch=master)](https://travis-ci.org/wiiitek/pl.kubiczak.felix.shark.felix)


Downloads [Felix OSGI framework][felix-framework] and unzips it
into the folder provided by `SHARK_HOME` environment variable (if it is set).

Project site available at [http://site.kubiczak.pl/][project-site]

Maven artifacts at [http://maven.kubiczak.pl/][custom-maven-repo]


Setup on windows
----------------

<pre>
D:\pl.kubiczak.felix.shark.felix\> set SHARK_HOME=D:\shark
D:\pl.kubiczak.felix.shark.felix\> mvn clean install
D:\pl.kubiczak.felix.shark.felix\> cd D:\shark\felix-framework
D:\shark\felix-framework\> windows-start.bat
</pre>


Setup on Linux
--------------

<pre>
user@machine [/home/user]# export SHARK_HOME=/home/user/shark
user@machine [/home/user]# mvn clean install
user@machine [/home/user]# cd shark/felix-framework
user@machine [/home/user/shark/felix-framework]# chmod 744 linux-start.sh
user@machine [/home/user/shark/felix-framework]# ./linux-start.sh
</pre>


License
-------

![CC BY-NC 4.0](https://licensebuttons.net/l/by-nc/4.0/88x31.png "Attribution-NonCommercial 4.0 International")

[Attribution-NonCommercial 4.0 International][license]

[license]: http://creativecommons.org/licenses/by-nc/4.0/
[project-site]: http://site.kubiczak.pl/
[custom-maven-repo]: http://maven.kubiczak.pl/
[felix-framework]: http://felix.apache.org/