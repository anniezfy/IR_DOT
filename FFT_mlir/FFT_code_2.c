//#include "FFT.h"
#include<cmath>



const int NUM = 4;
const int SIZE = NUM*(NUM+1)/2;


int mypow(int a,int b){
    int res=1;
    for(int i=0;i<b;i++){
        res*=a;
    }
    return res;
}

struct MyComplex {
    double real;
    double imag;
    

};

struct MyComplex add(struct MyComplex a,struct MyComplex b){
    struct MyComplex c={};
    c.real=a.real+b.real;
    c.imag=a.imag+b.imag;
    return c;
}
struct MyComplex sub(struct MyComplex a,struct MyComplex b){
    struct MyComplex c={};
    c.real=a.real-b.real;
    c.imag=a.imag-b.imag;
    return c;
}
struct MyComplex mul(struct MyComplex a,struct MyComplex b){
    struct MyComplex c={};
    c.real=a.real*b.real+(a.imag*b.imag)*(-1);
    c.imag=a.real*b.imag+a.imag*b.real;
    return c;
}


void f_func(struct MyComplex fft[1024],int i,int j,struct MyComplex w){
    struct MyComplex t,temp=add(fft[i], mul(w,fft[j]) );
    t.real=fft[i].real;
    t.imag=fft[i].imag;
    fft[i].real=temp.real;
    fft[i].imag=temp.imag;
    struct MyComplex temp1=sub(t, mul(w,fft[j]) );
    fft[j].real=temp1.real;
    fft[j].imag=temp1.imag;
}
struct MyComplex w_func(int m,int N){
    struct MyComplex c={0,0};
    c.real=cos(2*acos(-1)*m/N);
    c.imag=sin(-2*acos(-1)*m/N);
    return c;
}
int reverse(int n,int l){
    int i=0,r=0,t;
    while(i<l){
        t=n&1;
        n=n>>1;
        r+=t*mypow(2,l-1-i);
        i++;
    }
    return r;
}
struct MyComplex[] FFT(struct MyComplex A[1024];){
    for(int k=1;k<=32;k++){
    //int tempPr1=1024/mypow(2,k);
        for(int l=0;l<1024/(k*k);l++){
        //int tempPr2=mypow(2,k-1);
            for(int i=0;i<(k-1)*(k-1);i++){
                    f_func(A,l*k*k+i,l*k*k+i+(k-1)*(k-1),w_func(i,(k*k)));
            }
        }
    }
    return A;
}
