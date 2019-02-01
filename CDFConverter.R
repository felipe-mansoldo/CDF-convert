#	Written Jan 31, 2019 by Felipe Mansoldo
#	Copyright 2019 by Felipe Mansoldo

library(ncdf4)

ConvertCDFtoRAW <- function(filepath) {
nc <- nc_open(filepath)
actual_sampling_interval = ncvar_get(nc, nc$var$actual_sampling_interval);
actual_run_time_length = ncvar_get(nc, nc$var$actual_run_time_length);
ordinate_values = ncvar_get(nc, nc$var$ordinate_values);
index = c(0:(length(ordinate_values)-1));
time_val = index * actual_sampling_interval/60;
result = data.frame(time_val, ordinate_values)
colnames(result) <- c("minutes","intensity");
return(result)
}

MultipleCDFtoCSV <- function(InitialFolder,OutputDirectory=""){
  setwd(InitialFolder)
  CDFfiles = list.files(pattern = ".cdf$", recursive = TRUE, ignore.case = TRUE)
  FolderNames = dirname(file.path(CDFfiles))
  if (OutputDirectory!=""){FolderNames[]=OutputDirectory}
  FilesNames = basename(file.path(CDFfiles))
  ExportFilesNames = gsub(".cdf", ".csv", FilesNames, ignore.case = TRUE,perl = FALSE, fixed = FALSE)
  n_problem=0
  for (i in 1:length(CDFfiles)){
    print(paste0("Working on ",FilesNames[i]))
    convert <- try(write.table(ConvertCDFtoRAW(CDFfiles[i]), file = paste0(FolderNames[i],"/",ExportFilesNames[i]),row.names = FALSE,sep=";", dec="."))
    if (!is.null(convert)){
      print(paste0("Error ",FilesNames[i]))
      n_problem=n_problem+1;
    } else{
      print(paste0("Success ",FilesNames[i]))
    }
  }
  if (n_problem==0){print(paste0("Conversion to CSV was successful:",length(CDFfiles)," CDF files"))}else{print(paste0("Could not convert ",n_problem," files"))}
  # return()
}

SingleCDFtoCSV <- function(CDF_file_path,OutputDirectory=""){
  CDFfiles = CDF_file_path
  FolderNames = dirname(file.path(CDFfiles))
  if (OutputDirectory!=""){FolderNames[]=OutputDirectory}
  FilesNames = basename(file.path(CDFfiles))
  ExportFilesNames = gsub(".cdf", ".csv", FilesNames, ignore.case = TRUE,perl = FALSE, fixed = FALSE)
  n_problem=0
  for (i in 1:length(CDFfiles)){
    print(paste0("Working on ",FilesNames[i]))
    convert <- try(write.table(ConvertCDFtoRAW(CDFfiles[i]), file = paste0(FolderNames[i],"/",ExportFilesNames[i]),row.names = FALSE,sep=";", dec="."))
    if (!is.null(convert)){
      print(paste0("Error ",FilesNames[i]))
      n_problem=n_problem+1;
    } else{
      print(paste0("Success ",ExportFilesNames[i]))
    }
  }
  if (n_problem==0){print(paste0("Conversion to CSV was successful:",length(CDFfiles)," CDF file"))}else{print(paste0("Could not convert ",n_problem," file"))}
  # return()
}

