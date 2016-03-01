# ProjectiveDictionaryPairLearning.jl

#### previous DPL.jl

[![Build Status](https://travis-ci.org/quxiaofeng/ProjectiveDictionaryPairLearning.jl.svg)](https://travis-ci.org/quxiaofeng/ProjectiveDictionaryPairLearning.jl) [![Coverage Status](https://coveralls.io/repos/quxiaofeng/ProjectiveDictionaryPairLearning.jl/badge.svg?branch=master&service=github)](https://coveralls.io/github/quxiaofeng/ProjectiveDictionaryPairLearning.jl?branch=master)

## Installation

```julia
Pkg.add("ProjectiveDictionaryPairLearning")
```

## Demo

```julia
using ProjectiveDictionaryPairLearning
dpldemo()
```

The output should be something similar to this

>     The running time for DPL training is : 6.79 s
>     The running time for DPL testing is : 0.23 s
>     Recognition rate for DPL is : 97.579%

### Comparison with MATLAB version

Actually the MATLAB version runs much faster as below.

>     The running time for DPL training is : 3.12 s
>     The running time for DPL testing is : 0.17 s
>     Recognition rate for DPL is : 0.976

## Usage

### Prepare Data and Labels

+ Training Data `TrData`:   Column Vectors (Should be `normalize!`d)
+ Training Label `TrLabel`: Class Label Integers in A Row
+ Testing Data `TtData`:    Column Vectors (Should also be `normalize!`d )
+ Testing Label `TtLabel`:  Class Label Integers in A Row

### Set Parameters

```julia
DictSize = 30
τ = 0.05
λ = 0.003
γ = 0.0001
```

### DPL Training

```julia
DictMat, EncoderMat = TrainDPL(TrData, TrLabel, DictSize, τ, λ, γ)
```

### DPL Testing

```julia
PredictLabel, Error, Distance = ClassificationDPL(TtData, DictMat, EncoderMat, DictSize)
```
#### Ref: [`dpldemo()` in `ProjectiveDictionaryPairLearning.jl`](https://github.com/quxiaofeng/ProjectiveDictionaryPairLearning.jl/blob/master/src/ProjectiveDictionaryPairLearning.jl)

## Advanced Usage

Inner functions have been exposed to use.

+ `initialization.jl`: `DataMat, D, P, DataInvMat, A = initialization(Data, Label, DictSize, τ, λ, γ)`
+ `updateA!.jl`: `updateA!(A, D, DataMat, P, τ, DictSize)`
+ `updateD!.jl`: `updateD!(D, A, DataMat)`
+ `updateP!.jl`: `updateP!(P, A, DataInvMat, DataMat, τ)`

### Ref: [`TrainDPL.jl` in `ProjectiveDictionaryPairLearning.jl`](https://github.com/quxiaofeng/ProjectiveDictionaryPairLearning.jl/blob/master/src/TrainDPL.jl)

## Dependencies

+ [MAT.jl](https://github.com/simonster/MAT.jl)

---

## PAPER

The original matlab code is for the paper:

> + Shuhang Gu, Lei Zhang, Wangmeng Zuo, and Xiangchu Feng, ["Projective Dictionary Pair Learning for Pattern Classification,"](http://www4.comp.polyu.edu.hk/~cslzhang/paper/NIPS14_final.pdf) In NIPS 2014.
>
> + From **“dictionary learning”** to **“dictionary pair learning”**!
>

The julia port of this code is for the paper:

> Qu, Xiaofeng; Zhang, David; Lu, Guangming; and Guo, Zhenhua, [“Door knob hand recognition system,”](http://www.doorknob.ml/) Will appear in Systems, Man, and Cybernetics: Systems, IEEE Transactions on.

### Authors' Pages

+ [Lei Zhang's page](http://www4.comp.polyu.edu.hk/~cslzhang/)
+ [Shuhang Gu's Page](https://sites.google.com/site/shuhanggu/home)

### Downloads

+ [Download The Paper](http://www4.comp.polyu.edu.hk/~cslzhang/paper/NIPS14_final.pdf)
+ [Download The Supplement Material](http://www4.comp.polyu.edu.hk/~cslzhang/paper/NIPS14_supp_final.pdf)
+ [Download The MATLAB Code](http://www4.comp.polyu.edu.hk/~cslzhang/code/DPL_NIPS14.zip)

## DATASET

The example feature dataset (YaleB_Jiang) used in this code is from Dr. Zhuolin Jiang: http://www.umiacs.umd.edu/~zhuolin/projectlcksvd.html.

For the experiments on AR and caltech 101 dataset, we also used the feature datasets provided by Dr. Jiang.

For experiment on UCF50, we used the Action bank feature provided in: http://www.cse.buffalo.edu/~jcorso/r/actionbank/. Please refer to our paper for the detailed experimental setting.

---

## CONTACT

If you have problems with the paper, the algorithm or the original matlab code, please contact us at shuhanggu@gmail.com or cslzhang@comp.polyu.edu.hk.

If you have problems with the julia code, please contact us at xiaofeng.qu.hk@ieee.org.

## Thanks

+ A thank you to [afternone](https://github.com/afternone), who optimized the julia code

## TODO

+ ~~Add `test`~~
+ *NEW* add more tests
+ ~~Optimize the performance~~
+ *NEW* optimize the performance further
+ ~~Proper packaging~~

