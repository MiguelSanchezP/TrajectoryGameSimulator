%***************M-S-R[O]***************
points=[];
%Assuming centre is not P(0,0)
%printf("Centre's X: ");
%variableXtemp=input(' ');
%printf("Centre's Y: ");
%variableYtemp=input(' ');
%centre=[variableXtemp variableYtemp];
%Otherwise
centre=[0 0];
%Ask for data of the initial vector
printf("Initial Vector's Starting X: ");
variableXtemp=input(' ');
printf("Initial Vector's Starting Y: ");
variableYtemp=input(' ');
FirstPoint=[variableXtemp variableYtemp];
printf("Initial Vector's Final X: ");
variableXtemp=input(' ');
printf("Initial Vector's Final Y: ");
variableYtemp=input(' ');
SecondPoint=[variableXtemp variableYtemp]; 
%All necessary data has been introduced to the system at this point
%Representation of the centre
axis on;
plot([centre(1,1)],[centre(1,2)], 'ro')
hold on;
plot([FirstPoint(1,1) SecondPoint(1,1)],[FirstPoint(1,2) SecondPoint(1,2)],'r')
axis equal;
axis([-25 25 -25 25]);
%creation of variables and assignation of the first value
InitialPoint=FirstPoint;
FinalPoint=SecondPoint;
points=[points;InitialPoint];
accelerations=[];
angles=[]; 
longitudes=[];
MaxXPoint=0;
MinXPoint=0;
MaxYPoint=0;
MinYPoint=0;
%number of steps computed
k=1000;
accelerations=[accelerations;0 0];
angles=[angles;0];
longitudes=[longitudes;0 0];
%for method to compute points, and positions of the following vectors
for i=1:k
  Xpoint=FinalPoint(1,1);
  if Xpoint<0
    Xpoint=Xpoint*-1;
  endif
  Ypoint=FinalPoint(1,2);
  if Ypoint<0
    Ypoint=Ypoint*-1;
  endif
  Theta=asin(Ypoint/sqrt(power(Xpoint,2)+power(Ypoint,2)));
  a=[0 0];
  if (Theta<=deg2rad(67.5))&&(Theta>=deg2rad(22.5))
    a=[1 1];
  endif
  if Theta<deg2rad(22.5)
    a=[1 0];
  endif
  if Theta>deg2rad(67.5)
    a=[0 1];
  endif
  if FinalPoint(1,2)>0
    a(1,2)=a(1,2)*-1;  
  endif
  if FinalPoint(1,1)>0
    a(1,1)=a(1,1)*-1;
  endif
  longitudes=[longitudes;FinalPoint(1,1)-InitialPoint(1,1) FinalPoint(1,2)-InitialPoint(1,2)];
  points=[points;FinalPoint];
  accelerations=[accelerations;a];
  angles=[angles;Theta]; 
  if FinalPoint(1,1)>MaxXPoint
    MaxXPoint=FinalPoint(1,1);
  endif
  if FinalPoint(1,1)<MinXPoint
    MinXPoint=FinalPoint(1,1);
  endif
  if FinalPoint(1,2)>MaxYPoint
    MaxYPoint=FinalPoint(1,2);
  endif
  if FinalPoint(1,2)<MinYPoint
    MinYPoint=FinalPoint(1,2);
  endif  
  NewPoint=[2*FinalPoint(1,1)-InitialPoint(1,1)+a(1,1) 2*FinalPoint(1,2)-InitialPoint(1,2)+a(1,2)];
  InitialPoint=FinalPoint;
  FinalPoint=NewPoint;
endfor
%Adjustments to the axis
axis([1.1*MinXPoint 1.1*MaxXPoint 1.1*MinYPoint 1.1*MaxYPoint]);
%Check if the orbit is a closed one
defined=false;
startingPosition=1;
for i=2:k
  if longitudes(i,1)==0
    if longitudes(i,2)==0
      if !defined
        startingPosition=i;
        defined=true;
      endif  
    endif
  endif
endfor
StartingPoint=[points(startingPosition,1) points(startingPosition,2)];
FollowingPoint=[points(startingPosition+1,1) points(startingPosition+1,2)];
%Determine when the orbit is repeating itself
defined2=false;
finalPosition=1;
for i=startingPosition+1:k
  if points(i,1)==StartingPoint(1,1)
    if points(i,2)==StartingPoint(1,2)
      if points(i+1,1)==FollowingPoint(1,1)
        if points(i+1,2)==FollowingPoint(1,2)
          if !defined2
            finalPosition=i+1;
            defined2=true;
          endif
        endif
      endif
    endif
  endif
endfor
FinalPoint=points(finalPosition);
pointsDef=points(startingPosition:finalPosition,1:end);
longitudesDef=longitudes(startingPosition:finalPosition,1:end);
anglesDef=angles(startingPosition:finalPosition,1:end);
accelerationsDef=accelerations(startingPosition:finalPosition,1:end);
totalValues=finalPosition-startingPosition;
%***************M-S-Z[H-T-L-A-N]***************
%Writing stuff into a file 
file=fopen("Stuff.txt",'w');
fprintf(file,"Type of orbit: ");
if defined
  fprintf(file, "Opened\n\n");
endif
if defined==false
  fprintf(file, "Closed\n\n");
endif
fprintf(file,"Points Accelerations Angles Longitudes\n");
for i=1:totalValues-1
  fprintf(file,"(%d,%d)    (%d,%d)    %d    (%d,%d)\n",pointsDef(i,1),pointsDef(i,2),accelerationsDef(i,1),accelerationsDef(i,2),anglesDef(i),longitudesDef(i,1),longitudesDef(i,2));
endfor
fclose(file);
%Writing more stuff into another file
file=fopen("Stuff2.txt","w");
fprintf(file,"Pi-1        Pi        Vi        Ai        Ti\n");
for i=2:totalValues
  fprintf(file,"(%d,%d)    (%d,%d)    (%d,%d)    (%d,%d)    %d\n",pointsDef(i-1,1),pointsDef(i-1,2),pointsDef(i,1),pointsDef(i,2),longitudesDef(i,1),longitudesDef(i,2),accelerationsDef(i,1),accelerationsDef(i,2),anglesDef(i));
endfor
fclose(file);
%Representation of the orbit (closed only)
if defined==false
  for i=1:totalValues-1
    hold on;
    plot([pointsDef(i,1) pointsDef(i+1,1)],[pointsDef(i,2) pointsDef(i+1,2)],'k')
  endfor
endif
%Representation of the orbit (opened only)
if defined
  for i=1:(totalValues/2)-1
    hold on;
    plot([pointsDef(i,1) pointsDef(i+1,1)],[pointsDef(i,2) pointsDef(i+1,2)],'k')
  endfor
endif
