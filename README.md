# Brainstorm tests

Scripts to test Brainstorm releases (Source and Binary)

This repo is thought to be used only by the Brainstorm team, to automatically test Brainstorm source code with tutorial scripts. Data is downloaded using the neuroimage FTP server with.

## Testing Brainstorm source distribution

### With GitHub actions
Run the `NAME` GitHub action in the `master` branch of the `s` repository, indicate:
* **Test to run**, the name of the tutorial script to run
* **Req  the OS and Brainstorm user name to send an email once each test is done.

### Locally
You need a physical (or a virtual) machine with the OS to test and their respective [Matlab Runtime](https://www.mathworks.com/products/compiler/matlab-runtime.html) installed.

**Execution:**
```
matlab22b . -nodisplay -r "brainstorm test_brainstorm.m tutorial_connectivity Raymundo.Cassani local"
```
## Testing Brainstorm binary distribution

### Locally
You need a physical (or a virtual) machine with the OS to test and their respective [Matlab Runtime](https://www.mathworks.com/products/compiler/matlab-runtime.html) installed.
**Execution:**
```
./brainstorm3.command /usr/local/MATLAB/MATLAB_Runtime/R2022b test_brainstorm.m tutorial_connectivity Raymundo.Cassani local
```
