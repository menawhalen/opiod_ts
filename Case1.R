# Case 1 - Differing valus of K (the number of most recent changes)
# library for optimisation
library(tbart)

# Simulate data
source("sourcefiles/sim_data.R")

###################
# load in functions - for segmentation
###################
# DOUBLE CUSUM 
source("sourcefiles/bs_DC.R")
# INDEP
source("sourcefiles/PELT.R")
source("sourcefiles/ind.R")
# MRC
source("sourcefiles/mrc_mean.R")
source("sourcefiles/multiple_mrc.R")

n = 500
N = 100

# K = 1 MRC and mean diff eps = 1
set.seed(1)
sim = simulate.data( K=1 , eps=1.0 )
data = sim$data

# true MRC's each series
sim$mrc[ sim$series.mrc ]

# independent pelt segmentations
ind( data )

# DCBS
Bin_seg(data,10)

# MRC
mrc = mrc.mean( data , beta = 1.5*log(n) )
c = multiple.mrc( mrc , pmax=10 )
p.hat = c$MDL
c$locs[[p.hat]][ c$affected[[p.hat]] ]
