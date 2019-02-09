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
axis([-25 25 -25 25]);
%Representation of the initial vector and the center point
  InitialPoint=[points(1,1) points(1,2)];
  FinalPoint=[points(2,1) points(2,2)];
  accelerations=[];
for i=1:1000
  Xsub2=FinalPoint(1,1);
  if Xsub2<0
    Xsub2=Xsub2*-1;
  endif
  Ysub2=FinalPoint(1,2);
  if Ysub2<0
    Ysub2=Ysub2*-1;
  endif
%  DistanceToCenter=sqrt(power(Xsub2,2)+power(Ysub2,2));
  Thetasub2=asin(Ysub2/sqrt(power(Xsub2,2)+power(Ysub2,2)));
  %Thetasub2=atan(Xsub2/Ysub2);
  Asub1=[0 0];
  if (Thetasub2<=deg2rad(67.5))&&(Thetasub2>=deg2rad(22.5))
    Asub1=[1 1];
  endif
  if (Thetasub2>=deg2rad(0))&&(Thetasub2<deg2rad(22.5))
    Asub1=[1 0];
  endif
  if (Thetasub2<=deg2rad(90))&&(Thetasub2>deg2rad(67.5))
    Asub1=[0 1];
  endif
  if FinalPoint(1,2)>0
    Asub1(1,2)=Asub1(1,2)*-1;
  endif
  if FinalPoint(1,1)>0
    Asub1(1,1)=Asub1(1,1)*-1;
  endif
%  totalDistanceX=FinalPoint(1,1)-InitialPoint(1,1);
%  totalDistanceY=FinalPoint(1,2)-InitialPoint(1,2);
%  ClonedVector=[FinalPoint(1,1)+totalDistanceX FinalPoint(1,2)+totalDistanceY];
%  SubmittedVector=[ClonedVector(1,1)+Asub1(1,1) ClonedVector(1,2)+Asub1(1,2)];
  NewPoint=[2*FinalPoint(1,1)-InitialPoint(1,1)+Asub1(1,1) 2*FinalPoint(1,2)-InitialPoint(1,2)+Asub1(1,2)];
  hold on;
%  plot([FinalPoint(1,1) SubmittedVector(1,1)],[FinalPoint(1,2) SubmittedVector(1,2)],'k')
  plot([FinalPoint(1,1) NewPoint(1,1)],[FinalPoint(1,2) NewPoint(1,2)],'k')
  InitialPoint=FinalPoint;
%  FinalPoint=SubmittedVector;
  FinalPoint=NewPoint;
%  points=[points;SubmittedVector];
  points=[points;FinalPoint];
  accelerations=[accelerations;Asub1];
endfor
