## R CMD check results

── R CMD check results ──────────────────────────── bellreg 0.0.2 ────
Duration: 24m 32.1s

❯ checking compiled code ... OK
   WARNING
  ‘qpdf’ is needed for checks on size reduction of PDFs

❯ checking installed package size ... NOTE
    installed size is 66.4Mb
    sub-directories of 1Mb or more:
      libs  66.0Mb

❯ checking dependencies in R code ... NOTE
  Namespace in Imports field not imported from: ‘rstantools’
    All declared Imports should be used.

❯ checking for GNU extensions in Makefiles ... NOTE
  GNU make is a SystemRequirements.

0 errors ✔ | 1 warning ✖ | 3 notes ✖


* Package also checked using GHA workflow.

* This is an update from version 0.0.1 to 0.0.2.
