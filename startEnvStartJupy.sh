#!/bin/bash

# Ask the name of the python virtual enviroment
read -p 'Virtual env name: ' envvar

# Activate and get inside that virtual environment
source $envvar/bin/activate

# Start Jupyter
jupyter notebook &
