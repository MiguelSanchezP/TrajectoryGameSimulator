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
  InitialPoint=[points(1,1) points(1,2)];
  FinalPoint=[points(2,1) points(2,2)];
  accelerations=[];
for i=1:3
  theta1=atan(FinalPoint(1,1)/FinalPoint(1,2));
  a1=[0 0];
  if (theta1<0)
    theta1=theta1*-1;
  endif
  if (theta1<=1.178097 && theta1>=0.3926991)
    a1=[1 1];
  elseif (theta1>=0 && theta1<0.3926991)
    a1=[1 0];
  elseif (theta1<=1.570796 && theta1>1.178097)
    a1=[0 1];
  endif
  if (FinalPoint(1,2)>0)
    a1(1,2)=a1(1,2)*-1;
  endif
  if (FinalPoint(1,1)>0)
    a1(1,1)=a1(1,1)*-1;
  endif
%  InitialPoint=FinalPoint;
  TempPoint=FinalPoint;
  FinalPoint=[(FinalPoint(1,1)+(FinalPoint(1,1)-InitialPoint(1,1))+a1(1,1)) (FinalPoint(1,2)+(FinalPoint(1,2)-InitialPoint(1,2))+a1(1,2))];
  InitialPoint=TempPoint;
  %  FinalPoint=[(InitialPoint(1,1)+a1(1,1)) (InitialPoint(1,2)+a1(1,2))];
  
  points=[points;FinalPoint];
  accelerations=[accelerations;a1];
endfor