# 1 Create conda environment
sudo dnf install conda
conda create -n isis3 python=3.6
#conda init bash
#source ~/.bashrc
#New Terminal

#Anaconda 3.4 and up:
conda activate isis3


#Add the following channels to the environment
conda config --env --add channels conda-forge
conda config --env --add channels usgs-astrogeology

#Verify you have the correct channels:
conda config --show channels

#You should see:

#channels:
#    - usgs-astrogeology
#    - conda-forge
#    - defaults

#The order is important.  If conda-forge is before usgs-astrogeology, you will need to run:

#conda config --env --add channels usgs-astrogeology


#6 The environment is now ready to download ISIS3 and its dependencies:

conda install -c usgs-astrogeology isis3

#Finally, setup the environment variables:

#Execute the ISIS3 variable initialization script with default arguments.
#This script prepares default values for:  $ISISROOT/$ISIS3DATA/$ISIS3TESTDATA

echo $CONDA_PREFIX
#/home/nidhi/.conda/envs/isis3

python $CONDA_PREFIX/scripts/isis3VarInit.py

"""
#Created /home/nidhi/.conda/envs/isis3/data
#Created /home/nidhi/.conda/envs/isis3/testData
#Tried to create /home/nidhi/.conda/envs/isis3/etc/conda/activate.d, but it already exists.
#Tried to create /home/nidhi/.conda/envs/isis3/etc/conda/deactivate.d, but it already exists.
#Wrote /home/nidhi/.conda/envs/isis3/etc/conda/activate.d/env_vars.sh
#Wrote /home/nidhi/.conda/envs/isis3/etc/conda/deactivate.d/env_vars.sh
#Wrote /home/nidhi/.conda/envs/isis3/etc/conda/activate.d/env_vars.csh
#Wrote /home/nidhi/.conda/envs/isis3/etc/conda/deactivate.d/env_vars.csh
#Wrote /home/nidhi/.conda/envs/isis3/etc/conda/activate.d/env_vars.fish
#Wrote /home/nidhi/.conda/envs/isis3/etc/conda/deactivate.d/env_vars.fish
"""

##Close This terminal and open new

(isis3) [nidhi@localhost ~]$ echo $ISISROOT/$ISIS3DATA/$ISIS3TESTDATA
#/home/nidhi/.conda/envs/isis3//home/nidhi/.conda/envs/isis3/data//home/nidhi/.conda/envs/isis3/testData
(isis3) [nidhi@localhost ~]$ echo $ISISROOT
#/home/nidhi/.conda/envs/isis3
(isis3) [nidhi@localhost ~]$ echo $ISIS3DATA
#/home/nidhi/.conda/envs/isis3/data
(isis3) [nidhi@localhost ~]$ echo $ISIS3TESTDATA
#/home/nidhi/.conda/envs/isis3/testData


#Do if rsync is working
#######################################################################################################
#######################################################################################################
#Partial Download of ISIS3 Base Data (Required)

cd $ISIS3DATA
rsync -azv --delete --partial isisdist.astrogeology.usgs.gov::isis3data/data/base .



#sent 12,837 bytes  received 8,397,382,880 bytes  8,070,538.89 bytes/sec
#total size is 13,113,511,610  speedup is 1.56

#Chandrayaan Mission:

cd $ISIS3DATA
rsync -azv --exclude='kernels' --delete --partial isisdist.astrogeology.usgs.gov::isis3data/data/chandrayaan1 .

#sent 335 bytes  received 334,061,275 bytes  5,179,249.77 bytes/sec
#total size is 478,727,806  speedup is 1.43

#########################################################################################################
#########################################################################################################



#########################################################################################################
#########################################################################################################

#Path
#/home/nidhi/.conda/envs/isis3
#bin             data             embree-vars.sh   lib          man          plugins  scripts    testData         version
#conda_build.sh  doc              etc              libexec      mkspecs      qml      share      TestPreferences  x86_64-conda_cos6-linux-gnu
#conda-meta      docs             include          LICENSE.txt  mysql        README   ssl        translations
#COPYING         embree-vars.csh  IsisPreferences  make         phrasebooks  sbin     templates  var

cd $ISIS3DATA
#/home/nidhi/.conda/envs/isis3/data
#(isis3) [nidhi@localhost data]$ tree -L 1
.
#├── base
#└── chandrayaan1

#2 directories, 0 files
####################################################
cd $ISIS3DATA
git clone --recurse-submodules https://github.com/nilesh-iiita/ISIS3.git
git submodule update --init --recursive
cd ISIS3/
conda env create -n isis_install -f environment.yml
conda activate isis_install
mkdir build install

cd build/

cmake -DCMAKE_INSTALL_PREFIX=/home/nidhi/.conda/envs/isis3/data/ISIS3/install -Disis3Data=/home/nidhi/.conda/envs/isis3/data -Disis3TestData=/home/nidhi/.conda/envs/isis3/testData -DJP2KFLAG=OFF -DCMAKE_BUILD_TYPE=RELEASE -GNinja /home/nidhi/.conda/envs/isis3/data/ISIS3/isis

#	ISIS3DATA: /home/nidhi/.conda/envs/isis3/data
#	ISISTESTDATA: /home/nidhi/.conda/envs/isis3/testData
#	TEST OUTPUT DIR: /home/nidhi/.conda/envs/isis3/data/ISIS3/build/testOutputDir
#	INSTALL PREFIX: /home/nidhi/.conda/envs/isis3/data/ISIS3/install

#-- Configuring done
#-- Generating done
#-- Build files have been written to: /home/nidhi/.conda/envs/isis3/data/ISIS3/build

pwd
(isis_install) [nidhi@localhost build]$ pwd
#/home/nidhi/.conda/envs/isis3/data/ISIS3/build

#(isis_install) [nidhi@localhost build]$ ninja install
ninja install
#[1064/3331] Building CXX object objects/CMakeFiles/isis3.dir/control/objs/ControlMeasure/ControlMeasure.cpp.o

#home/nidhi/.conda/envs/isis_install/share/cmake-3.11/Modules/GoogleTestAddTests.cmake
#CMake Error at /home/nidhi/.conda/envs/isis_install/share/cmake-3.11/Modules/GoogleTestAddTests.cmake:39 (message):
#  Error running test executable.

#    Path: '/home/nidhi/.conda/envs/isis3/data/ISIS3/build/tests/runISISTests'
#    Result: Process terminated due to timeout
#    Output:

ninja install libisis3.so

ninja docs -j7

############################################################################################################
# Running
############################################################################################################
#On a fresh terminal

conda activate isis3
cd /home/nidhi/.conda/envs/isis3/data/ISIS3/install/bin/
./qview

############################################################################################################
############################################################################################################
############################################################################################################
#### Last
############################################################################################################
############################################################################################################
############################################################################################################

/home/nidhi/.conda/envs/isis3

#bin             data             embree-vars.sh   lib          man          plugins  scripts    testData         version
#conda_build.sh  doc              etc              libexec      mkspecs      qml      share      TestPreferences  x86_64-conda_cos6-linux-gnu
#conda-meta      docs             include          LICENSE.txt  mysql        README   ssl        translations
#COPYING         embree-vars.csh  IsisPreferences  make         phrasebooks  sbin     templates  var

cd data/

(isis3) [nidhi@localhost data]$ tree -d -L 2

.
├── base
│   ├── applications
│   ├── dems
│   ├── icons
│   ├── images
│   ├── kernels
│   ├── templates
│   ├── testData
│   ├── testing
│   └── translations
├── chandrayaan1
│   ├── bandBin
│   ├── testData
│   └── translations
└── ISIS3
    ├── build
    ├── gtest
    ├── install
    ├── isis
    └── recipe
##################
ISIS3/
├── build
├── gtest
├── install
├── isis
└── recipe

##################

(isis3) [nidhi@localhost data]$ tree -d -L 2 ISIS3/
ISIS3/
├── build
│   ├── bin
│   ├── cmake
│   ├── CMakeFiles
│   ├── docBuild
│   ├── docs
│   ├── inc
│   ├── lib
│   ├── make
│   ├── objects
│   ├── scripts
│   ├── Testing
│   ├── testOutputDir
│   ├── tests
│   └── unitTest
├── gtest
│   ├── ci
│   ├── googlemock
│   └── googletest
├── install
│   ├── bin
│   ├── docs
│   ├── lib
│   ├── make
│   ├── scripts
│   └── templates
├── isis
│   ├── 3rdParty
│   ├── cmake
│   ├── config
│   ├── make
│   ├── scripts
│   ├── sipfiles
│   ├── src
│   ├── templates
│   └── tests
└── recipe
