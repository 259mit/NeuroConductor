#DICOM
setwd("/Users/home/Downloads/BTech DS/NeuroHacking")
setwd("/Users/home/Downloads/BTech DS/NeuroHacking/Neurohacking_data-0.0/BRAINIX/DICOM/FLAIR")
a_slice = readDICOM("IM-0001-0011.dcm")
class(a_slice)
a_slice
d = dim(t(a_slice$img[[1]]))
image_11 = image(1:d[1],1:d[2],t(a_slice$img[[1]]),col=gray(0:64/64))
hist_1 = hist(a_slice$img[[1]][,],breaks = 50, xlab = "FLAIR", prob = T, col=rgb(0,0,1,1/4), main = "")
hdr_a_sclice = a_slice$hdr[[1]]
names(hdr_a_sclice)

#NIfTI
setwd("/Users/home/Downloads/BTech DS/NeuroHacking/Neurohacking_data-0.0/BRAINIX/DICOM")
all_slices_t1 = readDICOM("T1/")
hdr_all_11 = all_slices_t1$hdr[[11]]
nii_T1 = dicom2nifti(all_slices_t1)
d = dim(nii_T1)
d
class(nii_T1)
image_nifti_11 = image(1:d[1],1:d[2],nii_T1[,,11], col=gray(0:64/64), xlab="", ylab="")

setwd("/Users/home/Downloads/BTech DS/NeuroHacking/Neurohacking_data-0.0/BRAINIX/NIfTI")
fname = "Output_3D_file"
writeNIfTI(nim = nii_T1, filename = fname)
list.files(getwd(), pattern = "Output_3D_file")
list.files(getwd(), pattern = "T")
nii_T2=readNIfTI("T2.nii.gz", reorient = FALSE)
dim(nii_T2)


#DATA VIZ 1
print({nii_T1 = readNIfTI(fname = fname)})
image_nifti_11 = image(1:d[1],1:d[2],nii_T1[,,11], col=gray(0:64/64), xlab="", ylab="")
image(nii_T2)
oro.nifti::image(nii_T2)
orthographic(nii_T1, xyz=c(200,200,11))


#DATA VIZ 2
par(mfrow=c(1,2))
hist(nii_T1, breaks=75, prob=T, xlab="T1 Intensities",col=rgb(0,0,1,1/2), main="")
hist(nii_T1[nii_T1>20], breaks=75, prob=T, xlab="T1 Intensities>20",col=rgb(0,0,1,1/2), main="")
is_btw_300n400 <- ((nii_T1>300)&(nii_T1<400))
nii_T1_mask <-nii_T1
nii_T1_mask[!is_btw_300n400]<-NA
overlay(nii_T1,nii_T1_mask,z=11,plot.type="single")
overlay(nii_T1,nii_T1_mask)

