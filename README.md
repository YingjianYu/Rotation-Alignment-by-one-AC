# Rotation-Alignment-by-one-AC
This package is a MATLAB implementation of the *Rotation alignment of a camera¨CIMU system using a single affine correspondence* [1]. It includes a demo and corresponding data for rotation alignment of a camera-IMU system using only a single affine correspondence in minimal case.
**Authors:** Yu Yingjian, Banglei Guan et al.
# Reference
[1] Yingjian Yu, Banglei Guan, Xiangyi Sun, Zhang Li, and Friedrich Fraundorfer, "Rotation alignment of a camera¨CIMU system using a single affine correspondence," Appl. Opt. 60, 7455-7465 (2021).

If you use this package in an academic work, please cite:

@article{Yu:21,
	author = {Yingjian Yu and Banglei Guan and Xiangyi Sun and Zhang Li and Friedrich Fraundorfer},
	journal = {Appl. Opt.},
	keywords = {Cameras; Detectors; Gyroscopes; Image metrics; Image registration; Imaging noise},
	number = {24},
	pages = {7455--7465},
	publisher = {OSA},
	title = {Rotation alignment of a camera--IMU system using a single affine correspondence},
	volume = {60},
	month = {Aug},
	year = {2021},
	url = {http://ao.osa.org/abstract.cfm?URI=ao-60-24-7455},
	doi = {10.1364/AO.431909}
	}


# README
* **File**:  demo.m

* **Key function API**: [ RError,TError ] = get1acResult( Rimu1,Rimu2,A, Rfirst,x1,x2,Rzyxall,T12,d);

* **Input data for API**:

  Rimu1 3x3 -the rotation matrix from IMU1 to world frame

  Rimu2 3x3 -the rotation matrix from IMU2 to world frame

  (A, x1,x2)    - The A is the 2x2  affine matrix of affine correspondence, the x1 and x2 are the normalized image point correspondence.
  
  Rfirst           - The initial rotation matrix between camera and IMU.

  Rzyxall         - The ground truth of the rotation matrix between camera and IMU.

  T12              - The translation vector between camera1 and camera2.

  Let  eye1, eye2 be position coordinates in world frame of camera1 and camera2, then T12 =-( eye2 - eye1)'.

  d                  - The distance from eye1 to the plane.

* **Output data of API**:

  RError     - The error of the estimated rotation matrix between camera and IMU.

  TError     - The error of the recovered translation vector between camera1 and  camera2.

* **Input Data for demo**:

data.mat
