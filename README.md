# sqlright-artifact: The code, analysis scripts and results for USENIX 2022 Artifact Evaluation

Version: 1.0\
Update: May 24, 2022
Paper: Detecting Logical Bugs of DBMS with Coverage-based Guidance

This document is to help users reproduce the results we reported in our submission. 
It contains the following descriptions:

## Getting Started

### Operating System configuration and Source Code setup

All of the experiments are evaluated on a `X86-64` `Ubuntu 20.04 LTS` operating system. Before the start of the experiment, we need to configure a few system settings. 
```sh
# Open a terminal from the Ubuntu system if you are using a Desktop distribution. 
sudo apt-get install build-essential libreadline-dev zlib1g-dev flex bison libxml2-dev libxslt-dev libssl-dev libxml2-utils xsltproc
sudo apt-get install -y libpq-dev

# Disable On-demand CPU scaling
cd /sys/devices/system/cpu
echo performance | sudo tee cpu*/cpufreq/scaling_governor

# Avoid having crashes misinterpreted as hangs
sudo sh -c " echo core >/proc/sys/kernel/core_pattern "
```

And then, go to the path where you want to dump the sqlright source code:

```sh
cd ~ # Assuming the home directory
git clone git@github.com:PSU-Security-Universe/sqlright-artifact.git  # TODO: May refer to other link if we are using Zenodo. 
```

## 0. Artifact Expectation

## 1. Artifact Overview

Our paper presents `SQLRight`, a tool that combines coverage-based guidance, validity-oriented mutations and oracles to detect logical bugs in Database Management Systems. For Artifact Evaluation, we release:

- (1) The `SQLRight` source code. 
- (2) The paper's final version. 
- (3) Information and the script to reproduce the evaluated benchmarks. 


## 2. Comparison between different tools

### Comparison between different tools in `SQLite` with `NoREC` oracle: (Figure 6 a, c, f, i)

To run 



