# Efficient Adjoint Computation for Wavelet and Convolution Operators
This repository contains code to reproduce the figures in the IEEE Signal Processing Magazine Lecture Note "Efficient Adjoint Computation for Wavelet and Convolution Operators", by James Folberth and Stephen Becker.


## Wavelet
Our adjoint wavelet code is in the `wavelet/` directory.  The code to compute the adjoints of a few wavelet operators and extensions in provided in the `wavelet/adjoints/` directory.

The two driver routines are `driver.m` and `fval_driver.m`.  `driver.m` is a modified version of the driver from Beck and Teboulle's FISTA driver.  `fval_driver.m` and `fval_plotter.m` are used to plot the SSIM index vs. interation number.

We modified Beck+Teboulle's [FISTA code](https://web.iem.technion.ac.il/en/people/userprofile/becka.html) to suit our needs; it is licensed under the GNU GPLv2.  Our adjoint code lives in the `wavelet/adjoints/` directory, and is licensed under the MIT license.

* [FISTA](https://web.iem.technion.ac.il/en/people/userprofile/becka.html)
* [Structural SIMilarity (SSIM)](https://ece.uwaterloo.ca/~z70wang/research/ssim/)
* [HNO image deblurring toolbox](http://www.imm.dtu.dk/~pcha/HNO/)
* [USC SIPI image database](http://sipi.usc.edu/database/)
* [export_fig](https://www.mathworks.com/matlabcentral/fileexchange/23629-export-fig)


## Blind Channel Estimation
Our BCE code is in the `bce/` directory.  We collaborated with Brendan Rideout and Eva-Marie Nosal of the University of Hawaii at Manoa.  They provided us with simulated underwater acoustic channel data, which we used in our experiments.  We do not provide the data, but we do provide the code we used to produce Figure 4 in our lecture note.

* [Mark Schmidt's L1General](https://www.cs.ubc.ca/~schmidtm/Software/L1General.html)
