
functions{
#include chunks/links.stan
#include chunks/mylib.stan
}

data {
  int<lower=0> n;
  int<lower=0> p;
  int<lower=0> q;
  array[n] int<lower=0> y;
  matrix[n, p] X;
  matrix[n, q] Z;
  vector[n] offset1;
  vector[n] offset2;
  int link1;
  int link2;
  row_vector[p] xbar;
  vector<lower=0>[p] Sx;
  row_vector[q] zbar;
  vector<lower=0>[q] Sz;
  int<lower=0, upper=1> approach;
  real mu_beta;
  array[p] real sigma_beta;
  real mu_psi;
  array[q] real sigma_psi;
  int<lower=0, upper=1> has_int_z;
  int<lower=0, upper=1> has_int_x;
}

transformed data{
  int r = has_int_z + has_int_x;
}

parameters {
  vector[has_int_z == 0 ? 0 : 1] coef_intercept_z;
  vector[q] coef_psi;
  vector[has_int_x == 0 ? 0 : 1] coef_intercept_x;
  vector[p] coef_beta;
}

transformed parameters{
  vector[has_int_z == 0 ? 0 : 1] intercept_z;
  vector[q] psi = coef_psi ./ Sz;
  vector[has_int_x == 0 ? 0 : 1] intercept_x;
  vector[p] beta = coef_beta ./ Sx;

  if(has_int_z == 1){
    intercept_z = coef_intercept_z - zbar*psi;
  }
  if(has_int_x == 1){
    intercept_x = coef_intercept_x - xbar*beta;
  }
}

model{
    // likelihood:
    vector[n] loglik = loglik_zibellreg(y, X, Z, coef_intercept_z, coef_intercept_x, coef_psi, coef_beta, link1, link2, offset1, offset2, has_int_z, has_int_x, zbar, xbar, Sz, Sx);
    target += sum(loglik);
    if(approach==1){
      // prior distributions:
      coef_beta ~ normal(mu_beta, sigma_beta);
      coef_psi ~ normal(mu_psi, sigma_psi);
    }
}


 generated quantities{
  vector[approach == 1 ? n : 0] log_lik;
  if(approach == 1){  
    log_lik = loglik_zibellreg(y, X, Z, coef_intercept_z, coef_intercept_x, coef_psi, coef_beta, link1, link2, offset1, offset2, has_int_z, has_int_x, zbar, xbar, Sz, Sx);
  }
 }


