

  real lambertW(real x){
    real y;
    real w;
    y= sqrt( 1 + exp(1) *x);
    w=-1 + 2.036 * log( (1 + 1.14956131 * y)/(1 + 0.45495740*log(1+y)) );
    w = (w/(1+w)) * ( 1 + log(x/w) );
    w = (w/(1+w)) * ( 1 + log(x/w) );
    w = (w/(1+w)) * ( 1 + log(x/w) );
    return(w);
  }

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


real bell_lpmf(int x, real theta){
    real Bx;
    real lprob;
    Bx = bellnumber(x);
    lprob = x*log(theta) - exp(theta) + 1 + log(Bx) - lgamma(x+1);
    return lprob;
  }

// real bell_lpmf(int[] x, real theta){
//     int n = num_elements(x);
//     real Bx[n];
//     real lprob[n];
//     for(i in 1:n){
//       Bx[i] = bellnumber(x[i]);
//       lprob[i] = x[i]*log(theta) - exp(theta) + 1 + log(Bx[i]) - lgamma(x[i]+1);
//     }
//     return sum(lprob);
// }

real loglik_bell(array[] int x, array[] real theta){
    array[num_elements(x)] real lprob;
    for(i in 1:num_elements(x)){
      lprob[i] = x[i]*log(theta[i]) - exp(theta[i]);
    }
    return sum(lprob);
  }

vector loglik_bellreg(array[] int y, matrix X, vector beta, int link){
  int n = num_elements(y);
  vector[n] lprob;
  vector[n] lp = X*beta;
  vector[n] mu = linkinv_bell(lp, link);
  array[n] real theta;
  for(i in 1:n){
    theta[i] = lambert_w0(mu[i]);
    lprob[i] = bell_lpmf(y[i] | theta[i]);
  }
  return lprob;
}


vector loglik_zibellreg(array[] int y, matrix X, matrix Z, vector beta, vector psi, int link1, int link2){
    int n = num_elements(y);
    vector[n] lprob;
    vector[n] lp1 = Z*psi;
    vector[n] lp2 = X*beta;
    vector[n] mu = linkinv_bell(lp2, link2);
    vector[n] omega = linkinv_bern(lp1, link1);
    array[n] real theta;
    for(i in 1:n){
      omega[i] = inv_logit(lp1[i]);
      theta[i] = lambert_w0(mu[i]);
      if(y[i] == 0){
        lprob[i] = log_sum_exp(bernoulli_lpmf(1 | omega[i]), bernoulli_lpmf(0 | omega[i]) + bell_lpmf(y[i] | theta[i]));
      }else{
        lprob[i] = bernoulli_lpmf(0 | omega[i]) + bell_lpmf(y[i] | theta[i]);
      }
    }
  return lprob;
}

