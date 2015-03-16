# PAPER

This code is for the paper:

> + Shuhang Gu, Lei Zhang, Wangmeng Zuo, and Xiangchu Feng, ["Projective Dictionary Pair Learning for Pattern Classification,"](http://www4.comp.polyu.edu.hk/~cslzhang/paper/NIPS14_final.pdf) In NIPS 2014.
>
> + From **“dictionary learning”** to **“dictionary pair learning”**!
> 

## Authors' Pages

+ [Lei Zhang's page](http://www4.comp.polyu.edu.hk/~cslzhang/)

+ [Shuhang Gu's Page](https://sites.google.com/site/shuhanggu/home)

## Downloads

+ [Download The Paper](http://www4.comp.polyu.edu.hk/~cslzhang/paper/NIPS14_final.pdf)

+ [Download The Supplement Material](http://www4.comp.polyu.edu.hk/~cslzhang/paper/NIPS14_supp_final.pdf)

+ [Download The MATLAB Code](http://www4.comp.polyu.edu.hk/~cslzhang/paper/NIPS14_supp_final.pdf)

---

# DATASET

The example feature dataset (YaleB_Jiang) used in this code is from Dr. Zhuolin Jiang: http://www.umiacs.umd.edu/~zhuolin/projectlcksvd.html.

For the experiments on AR and caltech 101 dataset, we also used the feature datasets provided by Dr. Jiang.

For experiment on UCF50, we used the Action bank feature provided in: http://www.cse.buffalo.edu/~jcorso/r/actionbank/. Please refer to our paper for the detailed experimental setting.

---

# USAGE

    cd("Drive:\\Path\\to\\the\\src")
    include("DPL.jl")
    using DPL
    dpldemo()

## Example

Dowload the code to 'D:\code\nips14'

    cd("D:\\code\\DPL.jl\\src")
    include("DPL.jl")
    using DPL
    dpldemo()

The output should be (after the optimization by afternone)

>     The running time for DPL training is : 10.29 s
>     The running time for DPL testing is : 0.23 s
>     Recognition rate for DPL is : 0.976%

## Comparison with MATLAB version

Actually the MATLAB version runs much faster as below.

>     The running time for DPL training is : 3.27 s
>     The running time for DPL testing is : 0.19 s
>     Recognition rate for DPL is : 0.976% 

---

# CONTACT

If you have problems with the paper, the algorithm or the original matlab code, please contact us at shuhanggu@gmail.com or cslzhang@comp.polyu.edu.hk.

If you have problems with the julia code, please contact us at xiaofeng.qu.hk@ieee.org.

---

# TODO

+ ~~Add `test`~~
+ NEW add more tests
+ ~~Optimize the performance~~
+ NEW optimize the performance further
+ Proper packaging
