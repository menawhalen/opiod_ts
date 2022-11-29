ind = function( data ){
  
  n = dim(data)[2]
  N = dim(data)[1]  
  
  icp = numeric(N)
  for (j in 1:N){
    cpts = PELT(data[j,],2*log(n))$cpts
    icp[j] = cpts[length(cpts)]
  }
  
  return( icp )
  
}