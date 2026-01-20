
.onLoad <- function(libname, pkgname) {
  if(requireNamespace("emmeans", quietly = TRUE)){
    emmeans::.emm_register(c("bellreg", "bellreg"), pkgname)
    emmeans::.emm_register(c("bellreg", "zibellreg"), pkgname)
  }
}



