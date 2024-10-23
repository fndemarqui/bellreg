## R CMD check results

── R CMD check results ──────────────────────────────────────────────────────────── bellreg 0.0.2.2 ────
Duration: 3m 2.6s

❯ checking top-level files ... WARNING
  A complete check needs the 'checkbashisms' script.
  See section ‘Configure and cleanup’ in the ‘Writing R Extensions’
  manual.

❯ checking compiled code ... OK
   WARNING
  ‘qpdf’ is needed for checks on size reduction of PDFs

❯ checking installed package size ... NOTE
    installed size is 78.8Mb
    sub-directories of 1Mb or more:
      libs  78.4Mb

❯ checking for future file timestamps ... NOTE
  unable to verify current time

❯ checking dependencies in R code ... NOTE
  Namespace in Imports field not imported from: ‘rstantools’
    All declared Imports should be used.

❯ checking for GNU extensions in Makefiles ... NOTE
  GNU make is a SystemRequirements.

❯ checking compilation flags used ... NOTE
  Compilation used the following non-portable flag(s):
    ‘-mno-omit-leaf-frame-pointer’

0 errors ✔ | 2 warnings ✖ | 5 notes ✖

* This is an update from version 0.0.2.1 to 0.0.2.2
