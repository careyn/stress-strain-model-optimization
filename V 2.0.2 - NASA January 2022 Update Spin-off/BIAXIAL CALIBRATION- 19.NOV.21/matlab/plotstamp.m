function[]=plotstamp(fig_no,fname)
%
%
%'plotstamp.m' will create a figure window and 
%add the date and file used to create it
%
%INPUT:	
%The figure number for the figure (fig_no)
%The mfile used to create the data for file (fname)
%OUTPUT:	
%A figure window with the date and data creation file
%
%Usage: Call plotstamp before your plot command
%For example: 
%
%plotstamp(2,'mymfilename')
%plot(1:10)
%
%NOTE:	
%plotstamp turns hold "on". It does not work with loglog, semilogx/y functions
%
%Created: 21FEB02	WMJ
%Last Mod:02AUG03 

figure(fig_no);
%The following will add the date and mfile name to the plot 
axis;
mfname=	sprintf('%s ',fname);
xp=1.03;yp=0.1;
%h1=text(xp,yp,date);
h1=text(xp,yp,date);
h2=text(xp,yp*5,mfname);
set(h2,'FontName','times','FontSize',[8],'rotation',[-90],'units','normalized');
set(h1,'FontName','times','FontSize',[8],'rotation',[-90],'units','normalized');
hold on


