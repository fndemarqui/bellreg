

 real bellnumber(int n){
  if(n < 2){
    return(1);
  }else{
    int k;
    vector[n] B;
    vector[n] Bneu;
    B[1] = 1;
    for (i in 1:(n - 1)){
      k = i;
      Bneu[1] = B[i];
      for (j in 2:(i + 1)){
        Bneu[j] = B[j - 1] + Bneu[j - 1];
      }
      for(j in 1:n){
        B[j] = Bneu[j];
      }
    }
    return(Bneu[k + 1]);
  }
}

real log_belln(int n){
  if(n > 218){
    real b = exp(lambert_w0(n - 0.5));
    return lmultiply(n, b) + b - n - 0.5 + 0.5*(log(b) - log(b + n)) ;
  }else{
    return log(bellnumber(n));
  }
}

real bell_lpmf(array[] int x, real theta){
  int n = num_elements(x);
  real lprob = 0;
  for(i in 1:n){
    lprob += lmultiply(x[i], theta) - expm1(theta) + log_belln(x[i]) - lgamma(x[i]+1);
  }
  return lprob;
}

real loglik_bell(array[] int x, array[] real theta){
  real lprob = 0;
  for(i in 1:num_elements(x)){
    lprob += lmultiply(x[i], theta[i]) - exp(theta[i]);
  }
  return lprob;
}

vector loglik_bellreg(array[] int y, matrix X, vector offset, vector intercept, vector beta, int link, int has_int, row_vector xbar, vector S){
  int n = num_elements(y);
  int p = num_elements(beta);
  vector[n] lprob;
  vector[n] lp;
  vector[n] mu;
  array[n] real theta;
  array[n] int ones = ones_int_array(n);

  if(p>0){
    if(has_int == 1){
      lp = intercept[ones] + X*beta + offset;
    }else{
      lp = xbar*( beta ./ S) + X*beta + offset;
    }

  }else{
    lp = intercept[ones] + offset;
  }

  mu = linkinv_bell(lp, link);
  for(i in 1:n){
    theta[i] = lambert_w0(mu[i]);
    lprob[i] = bell_lpmf({y[i]} | theta[i]);
  }
  return lprob;
}


vector loglik_zibellreg(array[] int y, matrix X, matrix Z, vector intercept_z, vector intercept_x, vector psi, vector beta, int link1, int link2, vector offset1, vector offset2, int has_int_z, int has_int_x, row_vector zbar, row_vector xbar, vector Sz, vector Sx){
    int n = num_elements(y);
    int q = num_elements(psi);
    int p = num_elements(beta);
    vector[n] lprob;
    vector[n] lp1;
    vector[n] lp2;
    vector[n] mu;
    vector[n] omega;
    array[n] real theta;
    array[n] int ones = ones_int_array(n);

    if(q>0){
      if(has_int_z == 1){
        lp1 = intercept_z[ones] + Z*psi + offset1;
      }else{
        lp1 = zbar*( psi ./ Sz) + Z*psi + offset1;
      }

    }else{
      lp1 = intercept_z[ones] + offset1;
    }

    if(p>0){
      if(has_int_x == 1){
        lp2 = intercept_x[ones] + X*beta + offset2;
      }else{
        lp2 = xbar*( beta ./ Sx) + X*beta + offset2;
      }

    }else{
      lp2 = intercept_x[ones] + offset2;
    }

    mu = linkinv_bell(lp2, link2);
    omega = linkinv_bern(lp1, link1);

    for(i in 1:n){
      omega[i] = inv_logit(lp1[i]);
      theta[i] = lambert_w0(mu[i]);
      if(y[i] == 0){
        lprob[i] = log_sum_exp(bernoulli_lpmf(1 | omega[i]), bernoulli_lpmf(0 | omega[i]) + bell_lpmf({y[i]} | theta[i]));
      }else{
        lprob[i] = bernoulli_lpmf(0 | omega[i]) + bell_lpmf({y[i]} | theta[i]);
      }
    }
  return lprob;
}

