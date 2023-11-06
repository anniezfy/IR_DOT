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


void f(struct MyComplex fft[10],int i,int j,struct MyComplex w){
    struct MyComplex t,temp=add(fft[i], mul(w,fft[j]) );
    t.real=fft[i].real;
    t.imag=fft[i].imag;
    fft[i].real=temp.real;
    fft[i].imag=temp.imag;
    struct MyComplex temp1=sub(t, mul(w,fft[j]) );
    fft[j].real=temp1.real;
    fft[j].imag=temp1.imag;
}
struct MyComplex w(int m,int N){
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
struct MyComplex[] FFT(struct MyComplex A[SIZE], int lenth){
    struct MyComplex fft[10];
    int N,p=0,k,l,i,t;
    while(lenth>mypow(2,p))p++;
    N=mypow(2,p);
    //for(i=lenth;i<N;i++)A[i]={0,0};
    for(i=0;i<N;i++){
        int t=reverse(i,p);
        fft[i].real=A[t].real;
        fft[i].imag=A[t].imag;
    }
    int tempPr1=N/mypow(2,k);
    int tempPr2=mypow(2,k-1);
    for(k=1;k<=p;k++)
        for(l=0;l<tempPr1;l++)
            for(i=0;i<tempPr2;i++){
                    //int tempI=mypow(2,k)*l+i;
                    //int tempJ=mypow(2,k)*l+i+mypow(2,k-1);
                    // struct MyComplex t={fft[mypow(2,k)*l+i].real,fft[mypow(2,k)*l+i].imag};
                    // struct MyComplex temp=add(fft[mypow(2,k)*l+i], mul( w(i,mypow(2,k)) , fft[mypow(2,k)*l+i+mypow(2,k-1)] ));
                    // fft[mypow(2,k)*l+i].real=temp.real;
                    // fft[mypow(2,k)*l+i].imag=temp.imag;
                    // struct MyComplex temp1=sub(t, mul( w(i,mypow(2,k) ) ,fft[mypow(2,k)*l+i+mypow(2,k-1)] ));
                    // fft[mypow(2,k)*l+i+mypow(2,k-1)].real=temp1.real;
                    // fft[mypow(2,k)*l+i+mypow(2,k-1)].imag=temp1.imag;
                    f(fft,l*mypow(2,k)+i,l*mypow(2,k)+i+mypow(2,k-1),w(i,mypow(2,k)));
            }
                //struct Complex x=mul(ftt[0],fft[1]);
                // f(fft,l*mypow(2,k)+i,l*mypow(2,k)+i+mypow(2,k-1),w(i,mypow(2,k)));
    return fft;
//    i=0;
//    cout<<"FFT处理后结果："<<endl;
//    while(i<N)cout<<fft[i++]<<' ';
}