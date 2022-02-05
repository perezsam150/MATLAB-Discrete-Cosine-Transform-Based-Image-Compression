# MATLAB DCT-Based Image Compression
A program developed in MATLAB to perform Discrete Cosine Transform-based image compression on BMP, PNG, TIFF, and JPG images. The program can realize high compression ratio of *above 500%* and low Signal-to-Noise (SNR) percent error between the source and compressed images.
![enter image description here](https://i.imgur.com/1322Grc.png)  
# Prerequisites
The program was developed using MATLAB and requires the following dependencies:

 - MATLAB Runtime 9.11
 - Microsoft Visual C Runtime 2015
# Usage
The end-user can choose to run the source code using MATLAB or to run the windows program in the `windows_program` directory. When compiling via MATLAB, use the `deploytool` function or open the `DCT_Compress.prj` file. Sample images are provided in the `windows_program` directory. Images must have a resolution of 1196x1996.
# Results
Using the sample images, the program achieves a high compression ratio of over 1000% while preserving visual integrity as indicated by the low SNR percent error.

![Comparison of Images](https://i.imgur.com/mGGB6Ac.png)

Comparing the file sizes below reveals the high compression ratio as suggested by a reduction of over 1000%.

![enter image description here](https://i.imgur.com/c28wXuL.png)

Lastly, the program also writes a text file containing relevant details such as SNR, compression ratio and the SNR percent error between the source and compressed image.

![enter image description here](https://i.imgur.com/dGU0W38.png)
