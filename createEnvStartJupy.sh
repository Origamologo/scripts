#!/bin/bash

# Ask the name of the python virtual enviroment
read -p 'Virtual env name: ' envvar

# Create the virtual env
virtualenv $envvar

# Activate and get inside that virtual environment
source $envvar/bin/activate

# Install Jupyter inside the virtual env
pip3 install jupyter

# Start Jupyter
jupyter notebook &
