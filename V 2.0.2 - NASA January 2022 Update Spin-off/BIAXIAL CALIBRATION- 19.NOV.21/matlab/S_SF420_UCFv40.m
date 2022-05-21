function [tauj, S110, S11j, S120, S12j, S130, S13j, S220, S22j, S230, S23j, S660, S66j] = S_SF420_UCFv30

%retardation time [s]
tauj=[1e-9 1e-8 1e-7 1e-6 1e-5 1e-4 1e-3 1e-2 1e-1 1 1e1 1e2 1e3 1e4 1e5 1e6 1e7 1e8 1e9];

%Prony coefficients [1/MPa]
S110 = 3e-4;
S11j = [1.7427440e-4 6.5109057e-6 6.2842691e-5 1.0754311e-4 5.8577103e-5 1.5508027e-4 2.8438661e-4 4.5671545e-4 6.4613944e-4 8.6980460e-4 1.0174406e-3 1.1201386e-3 1.0881332e-3 8.6245215e-4 1.0593370e-3 1.1494698e-3 1.4144114e-3 9.2623404e-4 1.3703076e-4];   
S120 = -1.5e-4;
S12j = [-8.71372e-5 -3.25545e-6 -3.14213e-5 -5.37716e-5 -2.92886e-5 -7.75401e-5 -0.000142193 -0.000228358 -0.00032307 -0.000434902 -0.00050872 -0.000560069 -0.000544067 -0.000431226 -0.000529669 -0.000574735 -0.000707206 -0.000463117 -6.85154e-5];
S130=-8.83703229909437e-06;
S13j=[-6.89935996886376e-06	-1.01718305055239e-05	-1.24039611397835e-05	-1.17647307828037e-05	-1.28479923522826e-05	-1.32166751128142e-05	-1.21948620521657e-05	-9.13314024301320e-05	-0.00106225225063280	-0.000445037765458870	-0.000767600754971828	-0.00100665608254897	-0.000590180872345043	-0.000968756415550470	-0.000387244561628871	-0.000897878586338892	-0.000887072932072364	-0.00221293320931561	-0.00197086529640916];
S220 = 3e-4;
S22j = [1.0998367e-4 5.8649043e-5 2.4142765e-5 4.2217698e-5 1.5062738e-4 9.6093116e-5 2.5979678e-4 4.4622050e-4 4.7933786e-4 5.9115290e-4 7.5112198e-4 1.2373818e-3 1.2622477e-3 6.4407837e-4 8.2459510e-4 9.4358983e-4 1.7421522e-3 7.7977930e-4 9.7438006e-5];
S230 = -3.62660607643300e-06;
S23j=[-6.10891187732972e-06	-5.35519498607062e-06	-4.62810508566101e-06	-3.72698630778354e-06	-3.23264794154380e-06	-8.84064340731771e-06	-9.56356197815259e-07	-8.58813036259198e-06	-0.000395033630854113	-0.000621513280236718	-0.000249966714993818	-0.00192716844972149	-1.74254038112872e-06	-2.08246540897004e-05	-0.00154943367135962	-1.28272079598142e-05	-0.00228225358779545	-0.000210062137647827	-0.000109284230450614];
S660 = 0.0012;
S66j = [1.5048241e-6 4.8564773e-7 1.1495912e-4 3.4537697e-4 4.4141444e-4 3.7851546e-4 1.9050740e-3 1.2369637e-3 2.9077949e-3 1.5893981e-3 4.3942746e-3 3.5281134e-3 1.4208478e-3 2.0412667e-3 6.8347953e-3 2.6735171e-3 4.6575021e-3 4.9645784e-3 4.9958466e-3];

end
