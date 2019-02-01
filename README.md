# CDF-convert
Convert Agilent OpenLAB Chromatogram .CDF file into CSV

This R script converts Agilent OpenLAB .CDF files to .CSV format.
With "CDFConverter.R" you can convert a single file or a series of files of a certain folder (in recursive mode).
You can also choose a destination folder, or in default mode, it will export to the location of .CDF files.

# How to use it

## First include the script file in your document
```R
source(file="CDFConverter.R")
```

## Converting a single .CDF file to .CSV
For this you must call the function SingleCDFtoCSV(CDF_file_path, OutputDirectory)

Example:
```R
SingleCDFtoCSV("file1.cdf")
```
As the OutputDirectory parameter was omitted then the function will export to the same folder where the .CDF file is.
To export to a specific location:
```R
SingleCDFtoCSV("file1.cdf", "destination folder")
```

## Converting multiple .CDF files to .CSV
For this you must call the function MultipleCDFtoCSV(InitialFolder, OutputDirectory)

Example:
```R
MultipleCDFtoCSV("Input Folder")
```
As the OutputDirectory parameter was omitted then the function will export to the same folder where the .CDF file is.
To export to a specific location:

```R
MultipleCDFtoCSV("Input Folder", "destination folder")
```
