#!/bin/bash
#
# usage: 
#
# 

# sbatch options
#SBATCH --job-name=RUN_STEMP_TEST
# partition = dev/batch
#SBATCH --partition=batch
# qos = short/normal/medium/long/long_contrib
#SBATCH --qos=normal
#SBATCH --account=pi_strow
#SBATCH -N1
#SBATCH --mem-per-cpu=18000
#SBATCH --cpus-per-task 1
#SBATCH --time=02:00:00
#SBATCH --array=0-3

# matlab options
MATLAB=/usr/cluster/matlab/current/bin/matlab
MATOPT=' -nojvm -nodisplay -nosplash'

echo "Executing srun of stemp_test_all"
$MATLAB $MATOPT -r "addpath('~/git/rtp_prod2/cris/scripts'); stemp_test_all($1); exit"
    
echo "Finished with srun of stemp_test_all"



