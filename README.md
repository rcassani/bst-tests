# Brainstorm tests

Scripts to test Brainstorm releases (Source and Binary)

This repo is thought to be used only by the Brainstorm team, to automatically test Brainstorm source code with tutorial scripts. Data is downloaded using the neuroimage FTP server with.

## Testing Brainstorm source distribution

### With GitHub actions
Run the `Run tutorial (on Brainstorm source)` GitHub action in the `master` branch of the `brainstorm-tools/brainstorm3` repository, indicate:
* **Test to run**, the name of the tutorial script to run
* **Brainstorm username to send email**, a report will be send to this Brainstorm user once the tutorial is done.

| Tutorial name             | Info  | OS | :octocat: exec time |
|---------------------------|-------|----|-----------|
| tutorial_introduction     | [Link](https://neuroimage.usc.edu/brainstorm/Tutorials/AllIntroduction)          | 🐧🪟🍎 |  90 min |
| tutorial_connectivity     | [Link](https://neuroimage.usc.edu/brainstorm/Tutorials/Connectivity)             | 🐧🪟🍎 |  05 min |
| tutorial_coherence        | [Link](https://neuroimage.usc.edu/brainstorm/Tutorials/CorticomuscularCoherence) | 🐧🪟🍎 | 140 min |
| tutorial_ephys            | [Link](https://neuroimage.usc.edu/brainstorm/e-phys/Introduction)                | 🐧❌❌ |  XX min |
| tutorial_epilepsy         | [Link](https://neuroimage.usc.edu/brainstorm/Tutorials/Epilepsy)                 | 🐧🪟🍎 |  20 min |
| tutorial_epileptogenicity | [Link](https://neuroimage.usc.edu/brainstorm/Tutorials/Epileptogenicity)         | 🐧🪟🍎 |  25 min |
| tutorial_fem_tensors      | [Link](https://neuroimage.usc.edu/brainstorm/Tutorials/FemTensors)               | ❌❌❌ |  XX min |
| tutorial_neuromag         | [Link](https://neuroimage.usc.edu/brainstorm/Tutorials/TutMindNeuromag)          | 🐧🪟🍎 |  35 min |
| tutorial_phantom_ctf      | [Link](https://neuroimage.usc.edu/brainstorm/Tutorials/PhantomCtf)               | 🐧🪟🍎 |  20 min |
| tutorial_phantom_elekta   | [Link](https://neuroimage.usc.edu/brainstorm/Tutorials/PhantomElekta)            | 🐧🪟🍎 |  10 min |
| tutorial_practicalmeeg    | [Link](https://neuroimage.usc.edu/brainstorm/WorkshopParis2019)                  | 🐧🪟🍎 |  30 min |
| tutorial_raw              | [Link](https://neuroimage.usc.edu/brainstorm/Tutorials/MedianNerveCtf)           | 🐧🪟🍎 |  10 min |
| tutorial_resting          | [Link](https://neuroimage.usc.edu/brainstorm/Tutorials/Resting)                  | 🐧🪟❌ |  XX min |
| tutorial_simulations      | [Link](https://neuroimage.usc.edu/brainstorm/Tutorials/Simulations)              | ❌❌🍎 |  XX min |
| tutorial_yokogawa         | [Link](https://neuroimage.usc.edu/brainstorm/Tutorials/Yokogawa)                 | 🐧🪟🍎 |  60 min |


### Locally
You need a physical (or a virtual) machine with the OS to test and their respective [Matlab Runtime](https://www.mathworks.com/products/compiler/matlab-runtime.html) installed.

**Execution:**
```
matlab22b . -nodisplay -r "brainstorm test_brainstorm.m tutorial_connectivity BRAINSTORM_USERNAME local"
```
## Testing Brainstorm binary distribution

### Locally
You need a physical (or a virtual) machine with the OS to test and their respective [Matlab Runtime](https://www.mathworks.com/products/compiler/matlab-runtime.html) installed.
**Execution:**
```
./brainstorm3.command /usr/local/MATLAB/MATLAB_Runtime/R2022b test_brainstorm.m tutorial_connectivity BRAINSTORM_USERNAME local
```
