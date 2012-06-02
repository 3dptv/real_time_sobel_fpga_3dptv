# Real time Particle Image Velocimetry using FPGA on the camera #

This is an upgrade of the open source 3D-PTV software (http://ptvwiki.netcipia.net) from ETH Zurich
that works with the RAW data obtained using the MC1324 Sobel camera through GigE.
MC1324 is operated through Coyette or GenDEV applications, produces RAW binary
files per image (at 500 frames per second). The files include only the objects of
identified particles. More information is available from Mark Kreizer's manual on 
the wiki site of the [Turbulence Structure Laboratory](http://www.eng.tau.ac.il/~alexlib/efdl/pmwiki.php?n=People.MarkKreizer)

## How to cite this work 

Two dimensional case:
~~~
@article {springerlink:10.1007/s00348-009-0715-5,
   author = {Kreizer, Mark and Ratner, David and Liberzon, Alex},
   affiliation = {Turbulence Structure Laboratory, School of Mechanical Engineering, Tel Aviv University, Tel Aviv, Israel},
   title = {Real-time image processing for particle tracking velocimetry},
   journal = {Experiments in Fluids},
   publisher = {Springer Berlin / Heidelberg},
   pages = {105-110},
   volume = {48},
   issue = {1},
   url = {http://dx.doi.org/10.1007/s00348-009-0715-5},
   note = {10.1007/s00348-009-0715-5},
   year = {2010}
}
~~~

Three dimensional case using four view optical image splitter
~~~
@article {springerlink:10.1007/s00348-010-0964-3,
   author = {Kreizer, Mark and Liberzon, Alex},
   affiliation = {Turbulence Structure Laboratory, School of Mechanical Engineering, Tel Aviv University, Ramat Aviv, 69978 Israel},
   title = {Three-dimensional particle tracking method using FPGA-based real-time image processing and four-view image splitter},
   journal = {Experiments in Fluids},
   publisher = {Springer Berlin / Heidelberg},
   pages = {613-620},
   volume = {50},
   issue = {3},
   url = {http://dx.doi.org/10.1007/s00348-010-0964-3},
   note = {10.1007/s00348-010-0964-3},
   year = {2011}
}
~~~

## Installation: ##

1. Get ActiveTCL, install it in C:\Tcl (if different directory is used, compilation is necessary)
2. Get Sobel_2DPTV software from the http://ptvwiki.netcipia.net
3. Install in any directory, e.g. C:\PTV\Software\Sobel_2DPTV
4. Change the path to this directory in the ptv.tcl file, e.g.
    set auto_path "C:/PTV/Software/Sobel_2DPTV . $auto_path"
(note the / slash direction)

## Usage: ##
1. Run the software by double-clicking the start.bat
2. The Sobel mode pre-requisites are as follows:
   a) RAW files should appear in `/img directory`
   b) RAW files are numbered as: `00009197.raw`, i.e. 8 digits and then `#.raw`
   c) /res directory should exist
   d) software will use RAW files, write `_targets` file (useful for the test) in the `/img`
   directory and `rt_is.*`, `ptv_is.*` and `added.*` files in the `/res` directory
3. Use: 
   a) Start button
   b) Sequence -> Sequence with Sobel
   c) Tracking (with or without display, forward or backward). Don't use Sequence/Tracking or shaking. 

4. Add-ons
    a) In Matlab directory there are few codes that help for testing: 
    txt2image.m will generate images in the same directory from _targets files
    read_write_targets.m makes some sorting, not necessary after PTV, only if _targets are produced manually 
    by raw2targets.m 
    
See also: changes.txt
Author: Alex Liberzon, alex.liberzon@gmail.com
Version: 1.0.01
Date: September 17, 2008



  