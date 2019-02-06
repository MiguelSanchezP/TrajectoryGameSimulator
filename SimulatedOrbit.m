points=[];
%Assuming centre is not P(0,0)
%printf("Centre's X: ");
%variableXtemp=input(' ');
%printf("Centre's Y: ");
%variableYtemp=input(' ');
%centre=[variableXtemp variableYtemp];
%Otherwise
centre=[0 0];
printf("Initial Vector's Starting X: ");
variableXtemp=input(' ');
printf("Initial Vector's Starting Y: ");
variableYtemp=input(' ');
points=[points;variableXtemp variableYtemp];
printf("Initial Vector's Final X: ");
variableXtemp=input(' ');
printf("Initial Vector's Final Y: ");
variableYtemp=input(' ');
points=[points;variableXtemp variableYtemp];
%all data necessary has been introduced to the system
axis on;
plot([points(1,1) points(2,1)],[points(1,2) points(2,2)], 'r')
hold on;
plot([centre(1,1)],[centre(1,2)], 'ro')
axis equal;
axis([-10 10 -10 10]);
%Representation of the initial vector and the center point
finalVec=[points(2,1) points(2,2)];
theta1=atan(finalVec(1,1)/finalVec(1,2));
a1=[0 0];
if (theta1<=1.178097 && theta1>=0.3926991)
  a1=[1 1];
elseif (theta1>=0 && theta1<0.3926991)
  a1=[1 0];
elseif (theta1<=1.570796 && theta1>1.178097)
  a1=[0 1];
endif
if (finalVec(1,2)>0)
  a1(1,2)=a1(1,2)*-1;
endif
if (finalVec(1,1)>0)
  a1(1,1)=a1(1,1)*-1;
endif