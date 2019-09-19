run("Split Channels");
selectWindow("C2-img.tif");
run("Duplicate...", "duplicate");
rename("filter1.tif");
run("Duplicate...", "duplicate");
rename("filter2.tif");
selectWindow("filter1.tif");
run("Subtract Background...", "rolling=50 stack");
run("Enhance Contrast...", "saturated=0.3 normalize equalize process_all");
run("Gaussian Blur...", "sigma=4 stack");
setAutoThreshold("Minimum dark");
run("Analyze Particles...", "size=50.00-500.00 show=Masks exclude clear add stack");
selectWindow("filter2.tif");
run("Subtract Background...", "rolling=50 stack");
run("Enhance Contrast...", "saturated=0.3 normalize equalize process_all");
run("Gaussian Blur...", "sigma=4 stack");
setAutoThreshold("Minimum dark");
run("Analyze Particles...", "size=50.00-800.00 show=Masks exclude clear include stack in_situ");
selectWindow("Mask of filter1.tif");
run("Invert",  "stack")
imageCalculator("Multiply create stack", "filter2.tif", "Mask of filter1.tif")
selectWindow("Result of filter2.tif")
setAutoThreshold("Otsu dark");
run("Analyze Particles...", "size=30-350 circularity=0.6-1.00 show=Masks exclude include add in_situ stack");
run("Set Measurements...", "area mean min centroid center perimeter fit shape stack display redirect=None decimal=8");
selectWindow("C1-img.tif");
roiManager("Measure");
selectWindow("C2-img.tif");
roiManager("Measure");
selectWindow("C1-img.tif");
imageCalculator("AND stack", "C1-img.tif","filter2.tif");
imageCalculator("Subtract stack", "C1-img.tif","Result of filter2.tif");
selectWindow("C2-img.tif");
imageCalculator("AND stack", "C2-img.tif","filter2.tif");
imageCalculator("Subtract stack", "C2-img.tif","Result of filter2.tif");
selectWindow("Mask of filter1.tif");
run("Close");
selectWindow("ROI Manager")
run("Close");
selectWindow("filter2.tif")
run("Close");
selectWindow("filter1.tif")
run("Close");