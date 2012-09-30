%1

clear all;

%Finds European swaption price using Rebonato's formula
%as mentioned in page 43 in Brigo's Lecture notes at
%http://www.damianobrigo.it/bocconi2.pdf

global tau;
global T;
%----------------------------- parameters
tau = 0.5;
alpha=5; %start peg of swap
beta=42; %end peg of swap
dt=0.1; %time-step of monte carlo simulation
N=100; %scenarios
%----------------------------------------------

function ret = volatility(Tj,T_o)
	a = -0.05;
	b = 0.5;
	c = 1.5;
	d = 0.15;
	kj = 1;
	ret=kj * ((a + b * (Tj - T_o)) * exp(-c * (Tj - T_o)) + d);
endfunction

function ret = corr(Tj,Tk)
	beta = 0.1;
	ret=exp(-beta * abs(Tj - Tk));
endfunction

%based on eq. 6.32 
function ret = GetSwapRate(F,alpha,beta)
	global tau;
	tmp_sum=0;
	SR=1;
	tmp=1;
	for j=alpha:beta-1,
		tmp=tmp*(1/(1+tau*F(j)));
	end
	SR=1-tmp; %numerator 
	for i=alpha:beta-1,
		tmp=1;
		for j=alpha:i,
			tmp=tmp*(1/(1+tau*F(j)));	  
		end
		tmp_sum=tmp_sum + (tau*tmp);
	end
	SR=SR/tmp_sum;
	ret=SR;
endfunction

%load -force -ascii p_matrix.txt 
%discount curve data from table 2 for 7% flat
FlatCurve=[1.000000
0.966736
0.934579
0.903492
0.873439
0.844385
0.816298
0.789145
0.762895
0.737519
0.712986
0.689270
0.666342
0.644177
0.622750
0.602035
0.582009
0.562649
0.543934
0.525841
0.508349
0.491440
0.475093
0.459290
0.444012
0.429243
0.414964
0.401161
0.387817
0.374917
0.362446
0.350390
0.338735
0.327467
0.316574
0.306044
0.295864
0.286022
0.276508
0.267311
0.258419
0.249823
];

%discount curve data from table 2 for GBP curve
GBPCurve= [1.000000
0.969514
0.939441
0.909913
0.881024
0.852807
0.825482
0.799100
0.773438
0.749042
0.725408
0.702527
0.680361
0.659402
0.639171
0.619580
0.600668
0.582455
0.564873
0.547888
0.531492
0.515651
0.500360
0.485543
0.471240
0.457861
0.444977
0.432554
0.420575
0.409019
0.397888
0.387341
0.377196
0.367435
0.358056
0.348978
0.340292
0.331614
0.323265
0.315460
0.307945
0.300321
];

P=GBPCurve; %set to appropriate discount curve to use

F=zeros(size(P,1)-1,1);
T=0:tau:20.5;
for i=1:size(F),
	F(i)=(P(i)/P(i+1)-1)/tau;
end

SR=GetSwapRate(F,alpha,beta);
SR

nF=size(F); %no. of froward rates
rootdT=dt^0.5;
nFswap=beta-alpha;
%form a correlation matrix rho which represents 
%the correlation between forward rates
rho=zeros(nFswap,nFswap);
tmp_row=0;
tmp_col=0;
for i=alpha:beta-1,
	tmp_row=tmp_row+1;
	tmp_col=0;
	for j=alpha:beta-1,
		tmp_col=tmp_col+1;
		rho(tmp_row,tmp_col)=corr(T(i),T(j));
	end
end
chol_rho=chol(rho);
chol_rho;
mu=zeros(nFswap,1);
K=SR; %strike of swaption is ATM swap rate

denom=0;
for k=alpha:beta-1,
	tmp=1;
	for j=alpha:k,
		tmp=tmp/(1+tau*F(j));
	end
	denom=denom+tau*tmp;
end

w=F*0;
for i=alpha:beta-1,
	tmp=1;
	for j=alpha:i,
		tmp=tmp/(1+tau*F(j));
	end
	w(i)=tau*tmp/denom;
end

global integrand_i;
global integrand_j;
function ret=vol_integrand(t)
	global integrand_i;
	global integrand_j;
	global T;
	ret=volatility(T(integrand_i),t)*volatility(T(integrand_j),t);
endfunction

integrand_i=alpha;
integrand_j=alpha+1;

var_sum=0;
for i=alpha:beta-1,
	for j=alpha:beta-1,
		integrand_i=i;
		integrand_j=j;
		area=quad('vol_integrand',0,T(alpha));
		tmp1=w(i)*w(j)*F(i)*F(j)*corr(T(i),T(j));
		tmp=tmp1*area/(SR*SR);
		var_sum=var_sum+tmp;
	end
end
var_sum

%black price 
function ret= Black(K,Forward,v)
 d1=(log(Forward / K) + 0.5 * v * v) / v;
 d2 = d1 - v;
 Nd1=normal_cdf(d1);
 Nd2=normal_cdf(d2);
 ret=(Forward * Nd1 - K * Nd2);
endfunction



black_volatity=var_sum^0.5;
tmpsum=0;
for i=alpha:beta-1,
 tmpsum=tmpsum+tau*P(i+1);
end
%SR=GetSwapRate(F,alpha,beta); %fair value of swap
K=SR; %swaption is ATM
swaption_price=tmpsum*Black(K,K,black_volatity)*100;
tmpblack=Black(K,K,black_volatity);
tmpstr=sprintf('swap start=%f   \nswap end=%f      \nswaption price=%f',T(alpha),T(beta),swaption_price);
disp(tmpstr);

