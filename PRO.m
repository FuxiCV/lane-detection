clc;clear all;close all
s=600;
V=mmreader('F1.wmv');
Is=read(V,[1 s]);
r=240;c=320;
r1=round(r*0.4);r2=round(r*0.94);
ch=160;
ri=r2-r1;