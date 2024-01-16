
library(bellreg)

# ML approach:
data(faults)
mle <- bellreg(nf ~ lroll, data = faults, approach = "mle")
summary(mle)
coef(mle)
vcov(mle)
confint(mle)

# Bayesian approach:
bayes <- bellreg(nf ~ lroll, data = faults, approach = "bayes", refresh = FALSE)
summary(bayes)
