
functions{
#include chunks/links.stan
#include chunks/mylib.stan
}

data{
  int<lower=1> n;
  int<lower=0> p;
  array[n] int y;
  matrix[n, p] X;
  vector[n] offset;
  int<lower = 1, upper = 3> link;
  int<lower=0, upper=1> approach;
  real mu_int;
  real<lower=0> sigma_int;
  real mu_beta;
  array[p] real sigma_beta;
  int has_int;
  row_vector[p] xbar;
  vector[p] S;
}


parameters{
  vector[has_int == 0 ? 0 : 1] coef_intercept;
  vector[p] coef_beta;
}


transformed parameters{
  vector[has_int == 0 ? 0 : 1] intercept;
  vector[p] beta = coef_beta ./ S;
  if(has_int == 1){
    intercept = coef_intercept - xbar*beta;
  }
}

model{
  vector[n] lp;
  vector[n] mu;
  array[n] int ones = ones_int_array(n);

  if(p>0){
    if(has_int == 1){
      lp = coef_intercept[ones] + X*coef_beta + offset;
    }else{
      lp = xbar*( coef_beta ./ S) + X*coef_beta + offset;
    }

  }else{
    lp = coef_intercept[ones] + offset;
  }


  mu = linkinv_bell(lp, link);
  array[n] real theta;
  for(i in 1:n){
    theta[i] = lambert_w0(mu[i]); // Stan implementation
  }

  target += loglik_bell(y, theta);
  if(approach==1){
    if(p>0){
      coef_beta ~ normal(mu_beta, sigma_beta);
    }
    if(has_int==1){
      coef_intercept ~ normal(mu_int, sigma_int);
    }
  }

}


generated quantities{
  vector[approach == 1 ? n : 0] log_lik;
  if(approach == 1){
    log_lik = loglik_bellreg(y, X, offset, coef_intercept, coef_beta, link, has_int, xbar, S);
  }
}



