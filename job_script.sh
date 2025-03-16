#!/bin/bash
#SBATCH --job-name=n15             # Name of your job
#SBATCH --output=%x_%j.out            # Output file (%x for job name, %j for job ID)
#SBATCH --error=%x_%j.err             # Error file
#SBATCH --partition=P100              # Partition to submit to (A100, V100, etc.)
#SBATCH --gres=gpu:1                  # Request 1 GPU
#SBATCH --mem=32G                     # Request 32 GB of memory
#SBATCH --time=26:00:00               # Time limit for the job (hh:mm:ss)

# Print job details
echo "Starting job on node: $(hostname)"
echo "Job started at: $(date)"


# Activate the environment
source ~/.bashrc
conda activate delires-env

# Execute the Python script with specific arguments
srun python -m torch.distributed.launch --nproc_per_node=1 --master_port=4321 basicsr/train_w_logger.py -opt options/train/GoPro/NAFNet-width32-newgate.yml --launcher pytorch

# Print job completion time
echo "Job finished at: $(date)"
