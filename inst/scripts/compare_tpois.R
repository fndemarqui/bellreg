# ============================================================================
# Comparison: bellreg::tpois vs extraDistr::tpois
# ============================================================================
# This script compares the truncated Poisson implementation in bellreg
# with the implementation in the extraDistr package.

library(extraDistr)
devtools::load_all()  # Load bellreg functions

# ----------------------------------------------------------------------------
# Setup: Define parameters for comparison
# ----------------------------------------------------------------------------
lambda <- 5
lower <- 0
upper <- 10
x_vals <- 0:15
n_samples <- 10000

cat("Parameters:\n")
cat("  lambda =", lambda, "\n")
cat("  lower =", lower, "(exclusive)\n")
cat("
  upper =", upper, "(inclusive)\n\n")

# ----------------------------------------------------------------------------
# 1. Density comparison (dtpois)
# ----------------------------------------------------------------------------
cat("=== Density Comparison (dtpois) ===\n\n")

# bellreg implementation
d_bellreg <- dtpois(x_vals, lambda = lambda, lower = lower, upper = upper)

# extraDistr implementation (uses 'a' for lower, 'b' for upper)
d_extraDistr <- extraDistr::dtpois(x_vals, lambda = lambda, a = lower, b = upper)

density_comparison <- data.frame(
  x = x_vals,
  bellreg = round(d_bellreg, 8),
  extraDistr = round(d_extraDistr, 8),
  diff = round(d_bellreg - d_extraDistr, 12)
)

print(density_comparison)
cat("\nMax absolute difference:", max(abs(density_comparison$diff), na.rm = TRUE), "\n\n")

# ----------------------------------------------------------------------------
# 2. CDF comparison (ptpois)
# ----------------------------------------------------------------------------
cat("=== CDF Comparison (ptpois) ===\n\n")

# bellreg implementation
p_bellreg <- ptpois(x_vals, lambda = lambda, lower = lower, upper = upper)

# extraDistr implementation
p_extraDistr <- extraDistr::ptpois(x_vals, lambda = lambda, a = lower, b = upper)

cdf_comparison <- data.frame(
  x = x_vals,
  bellreg = round(p_bellreg, 8),
  extraDistr = round(p_extraDistr, 8),
  diff = round(p_bellreg - p_extraDistr, 12)
)

print(cdf_comparison)
cat("\nMax absolute difference:", max(abs(cdf_comparison$diff), na.rm = TRUE), "\n\n")

# ----------------------------------------------------------------------------
# 3. Quantile comparison (qtpois)
# ----------------------------------------------------------------------------
cat("=== Quantile Comparison (qtpois) ===\n\n")

probs <- seq(0.1, 0.9, by = 0.1)

# bellreg implementation
q_bellreg <- qtpois(probs, lambda = lambda, lower = lower, upper = upper)

# extraDistr implementation
q_extraDistr <- extraDistr::qtpois(probs, lambda = lambda, a = lower, b = upper)

quantile_comparison <- data.frame(
  p = probs,
  bellreg = q_bellreg,
  extraDistr = q_extraDistr,
  diff = q_bellreg - q_extraDistr
)

print(quantile_comparison)
cat("\nMax absolute difference:", max(abs(quantile_comparison$diff), na.rm = TRUE), "\n\n")

# ----------------------------------------------------------------------------
# 4. Random generation comparison (rtpois)
# ----------------------------------------------------------------------------
cat("=== Random Generation Comparison (rtpois) ===\n\n")

set.seed(123)
r_bellreg <- rtpois(n_samples, lambda = lambda, lower = lower, upper = upper)

set.seed(123)
r_extraDistr <- extraDistr::rtpois(n_samples, lambda = lambda, a = lower, b = upper)

cat("Summary statistics (bellreg):\n")
print(summary(r_bellreg))
cat("\nSummary statistics (extraDistr):\n")
print(summary(r_extraDistr))

cat("\nMean difference:", mean(r_bellreg) - mean(r_extraDistr), "\n")
cat("SD difference:", sd(r_bellreg) - sd(r_extraDistr), "\n\n")

# Frequency table comparison
cat("Frequency comparison:\n")
freq_comparison <- data.frame(
  value = (lower + 1):upper,
  bellreg = as.numeric(table(factor(r_bellreg, levels = (lower + 1):upper))),
  extraDistr = as.numeric(table(factor(r_extraDistr, levels = (lower + 1):upper)))
)
freq_comparison$bellreg_prop <- freq_comparison$bellreg / n_samples
freq_comparison$extraDistr_prop <- freq_comparison$extraDistr / n_samples
freq_comparison$theoretical <- dtpois((lower + 1):upper, lambda, lower, upper)

print(freq_comparison)

# ----------------------------------------------------------------------------
# 5. Edge cases comparison
# ----------------------------------------------------------------------------
cat("\n=== Edge Cases ===\n\n")

# Test with different truncation bounds
cat("Test: Zero-truncated Poisson (lower=0, upper=Inf)\n")
x_test <- 1:10
d_bell_zt <- dtpois(x_test, lambda = 3, lower = 0, upper = Inf)
d_extra_zt <- extraDistr::dtpois(x_test, lambda = 3, a = 0, b = Inf)
cat("Max diff:", max(abs(d_bell_zt - d_extra_zt), na.rm = TRUE), "\n\n")

cat("Test: Right-truncated Poisson (lower=-Inf, upper=5)\n")
x_test <- 0:8
d_bell_rt <- dtpois(x_test, lambda = 3, lower = -Inf, upper = 5)
d_extra_rt <- extraDistr::dtpois(x_test, lambda = 3, a = -Inf, b = 5)
cat("Max diff:", max(abs(d_bell_rt - d_extra_rt), na.rm = TRUE), "\n\n")

# ----------------------------------------------------------------------------
# 6. Visual comparison
# ----------------------------------------------------------------------------
cat("=== Visual Comparison ===\n")
cat("(Generating plots...)\n\n")

par(mfrow = c(2, 2))

# Density plot
x_plot <- (lower + 1):upper
plot(x_plot, dtpois(x_plot, lambda, lower, upper),
     type = "h", lwd = 3, col = "blue",
     main = "Density Comparison",
     xlab = "x", ylab = "P(X = x)")
points(x_plot + 0.1, extraDistr::dtpois(x_plot, lambda, lower, upper),
       type = "h", lwd = 3, col = "red")
legend("topright", legend = c("bellreg", "extraDistr"),
       col = c("blue", "red"), lwd = 3, cex = 0.8)

# CDF plot
plot(x_plot, ptpois(x_plot, lambda, lower, upper),
     type = "s", lwd = 2, col = "blue",
     main = "CDF Comparison",
     xlab = "x", ylab = "P(X <= x)")
lines(x_plot, extraDistr::ptpois(x_plot, lambda, lower, upper),
      type = "s", lwd = 2, col = "red", lty = 2)
legend("bottomright", legend = c("bellreg", "extraDistr"),
       col = c("blue", "red"), lwd = 2, lty = c(1, 2), cex = 0.8)

# Histogram of random samples (bellreg)
hist(r_bellreg, breaks = seq(lower + 0.5, upper + 0.5, by = 1),
     main = "Random Samples (bellreg)",
     xlab = "x", col = "lightblue", freq = FALSE)
lines(x_plot, dtpois(x_plot, lambda, lower, upper),
      type = "h", lwd = 2, col = "blue")

# Histogram of random samples (extraDistr)
hist(r_extraDistr, breaks = seq(lower + 0.5, upper + 0.5, by = 1),
     main = "Random Samples (extraDistr)",
     xlab = "x", col = "lightcoral", freq = FALSE)
lines(x_plot, extraDistr::dtpois(x_plot, lambda, lower, upper),
      type = "h", lwd = 2, col = "red")

par(mfrow = c(1, 1))

cat("Comparison complete!\n")
