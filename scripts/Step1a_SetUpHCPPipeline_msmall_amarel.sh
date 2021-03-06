#!/bin/bash
#sourcing script is the same for nm3 and amarel

echo "This script must be SOURCED to correctly setup the environment prior to running any of the other HCP scripts contained here"

#**change this
#basedir=/home/rdm146/
#basedir=/projects/f_mc1689_1/

HCPbasedir="/projects/f_keanebp/" # This is the location of the HCP folders.

# Set up FSL (if not already done so in the running environment)
# Uncomment the following 2 lines (remove the leading #) and correct the FSLDIR setting for your setup
#export FSLDIR=/usr/share/fsl/5.0
#*hcp v2 is recommended to run on fsl 5.0.6
export FSLDIR=${HCPbasedir}/HCP_v2_prereqs/fsl
. ${FSLDIR}/etc/fslconf/fsl.sh

# Let FreeSurfer know what version of FSL to use
# FreeSurfer uses FSL_DIR instead of FSLDIR to determine the FSL version
export FSL_DIR="${FSLDIR}"

# Set up FreeSurfer (if not already done so in the running environment)
# Uncomment the following 2 lines (remove the leading #) and correct the FREESURFER_HOME setting for your setup
#export FREESURFER_HOME=/usr/local/bin/freesurfer
#*hcp v2 requires access to a special HCP version of freesurfer
export FREESURFER_HOME=${HCPbasedir}/HCP_v2_prereqs/freesurfer
source ${FREESURFER_HOME}/SetUpFreeSurfer.sh > /dev/null 2>&1

# Set up specific environment variables for the HCP Pipeline
export HCPPIPEDIR=${HCPbasedir}/HCP_v2_prereqs/HCP_Pipelines_v3_25_1
export CARET7DIR=${HCPbasedir}/HCP_v2_prereqs/workbench/bin_rh_linux64
export MSMBINDIR=${HCPbasedir}/HCP_v2_prereqs/MSMbinaries/ecr05/MSM_HOCR_v2/Centos/
export MSMCONFIGDIR=${HCPPIPEDIR}/MSMConfig

# RM edit
#*FSL_FIXDIR is essential for FIX; MATLAB_COMPILER_RUNTIME is optional (need for running matlab scripts as 'compiled' binaries; running as interpreted for now, but specify anyway)
#*Also make sure you modify the settings.sh file in FSL_FIXDIR appropriately
#*Note that certain scripts in the fixdir have been modified by RM so that it runs smoothly on different systems (e.g. addpath to cifti toolboxes for matlab functions)
export MATLAB_COMPILER_RUNTIME=${HCPbasedir}/HCP_v2_prereqs/MATLAB_Compiler_Runtime/v83
export FSL_FIXDIR=${HCPbasedir}/HCP_v2_prereqs/fix1.065
#also need to add basedir for fixica to work (in settings.sh)
export FSL_FIX_basedir=${HCPbasedir}

export HCPPIPEDIR_Templates=${HCPPIPEDIR}/global/templates
export HCPPIPEDIR_Bin=${HCPPIPEDIR}/global/binaries
export HCPPIPEDIR_Config=${HCPPIPEDIR}/global/config

export HCPPIPEDIR_PreFS=${HCPPIPEDIR}/PreFreeSurfer/scripts
export HCPPIPEDIR_FS=${HCPPIPEDIR}/FreeSurfer/scripts
export HCPPIPEDIR_PostFS=${HCPPIPEDIR}/PostFreeSurfer/scripts
export HCPPIPEDIR_fMRISurf=${HCPPIPEDIR}/fMRISurface/scripts
export HCPPIPEDIR_fMRIVol=${HCPPIPEDIR}/fMRIVolume/scripts
export HCPPIPEDIR_tfMRI=${HCPPIPEDIR}/tfMRI/scripts
export HCPPIPEDIR_dMRI=${HCPPIPEDIR}/DiffusionPreprocessing/scripts
export HCPPIPEDIR_dMRITract=${HCPPIPEDIR}/DiffusionTractography/scripts
export HCPPIPEDIR_Global=${HCPPIPEDIR}/global/scripts
export HCPPIPEDIR_tfMRIAnalysis=${HCPPIPEDIR}/TaskfMRIAnalysis/scripts

#*RM edit - adding export path for global/matlab scripts - these contain ciftisave/open etc that are required for FIXICA to run correctly
export HCPPIPEDIR_global_matlab=${HCPPIPEDIR}/global/matlab
export FSL_FIX_GIFTI=${HCPPIPEDIR}/global/matlab/gifti-1.6

#try to reduce strangeness from locale and other environment settings
export LC_ALL=C
export LANGUAGE=C
#POSIXLY_CORRECT currently gets set by many versions of fsl_sub, unfortunately, but at least don't pass it in if the user has it set in their usual environment
unset POSIXLY_CORRECT
