%***************M-S-R[O]***************
points=[];%Creation of the "points" variable
%Assuming centre is not P(0,0)
#printf("Centre's X: ");%Ask for the centre X value
#variableXtemp=input(' ');%Read and store the input given by the user
#printf("Centre's Y: ");%Ask for the centre Y value
#variableYtemp=input(' ');%Read and store the input given by the user
#centre=[variableXtemp variableYtemp];%Assign the centre variable the coordinates determined by the user
%Otherwise
centre=[0 0];%Created variable centre with given coordinates (0,0)
printf("Initial Vector's Starting X: ");%Ask for the starting X value of the initial vector
variableXtemp=input(' ');%Read and store the input given by the user
printf("Initial Vector's Starting Y: ");%Ask for the starting Y value of the initial vector
variableYtemp=input(' ');%Read and store the input given by the user
FirstPoint=[variableXtemp variableYtemp];%Create "FirstPoint" variable to store the coordinates of the specified point
printf("Initial Vector's Final X: ");%Ask for the final X value of the initial vector
variableXtemp=input(' ');%Read and store the input given by the user
printf("Initial Vector's Final Y: ");%Ask for the final Y value of the initial vector
variableYtemp=input(' ');%Read and store the input given by the user
SecondPoint=[variableXtemp variableYtemp];%Create "SecondPoint" variable to store the coordinates of the specified point 
%All necessary data has been introduced to the system at this point
%Representation of the centre and the initial vector
axis on;%Show axis in the plot screen
plot([centre(1,1)],[centre(1,2)], 'ro')%Represent the centre with an O and coloured red
hold on;%Maintain the former plots in the screen
plot ([FirstPoint(1,1) SecondPoint(1,1)],[FirstPoint(1,2) SecondPoint(1,2)],'r')%represent the initial vector coloured red
axis equal;%Make both axis have the same scale
axis([-25 25 -25 25]);%Make both axis represent from a determined value to another
InitialPoint=FirstPoint;%Assign the initial vector's tail coordinates to the new variable "InitialPoint"
FinalPoint=SecondPoint;%Assign the final vector's head coordinates to the new variable "FinalPoint"
accelerations=[];%Create the "accelerations" variable
angles=[];%Create the "angles" variable 
longitudes=[];%Create the "longitudes" variable
MaxXPoint=0;
MinXPoint=0;
MaxYPoint=0;
MinYPoint=0;
k=1000;%Create "k" variable (number of steps are going to be computed)
points=[points;InitialPoint];
accelerations=[accelerations;0 0];
angles=[angles;0];
longitudes=[longitudes;0 0];
for i=1:k %Creation of a for loop to repeat the process of finding new vectors and representing
  Xpoint=FinalPoint(1,1);%Assign the "FinalPoint" X value to "Xpoint" variable
  if Xpoint<0%Creation of an if statement to check if "Xpoint" is smaller than 0
    Xpoint=Xpoint*-1;%If "Xpoint" is smaller than 0 it is multiplied by -1
  endif%Close the if statement
  Ypoint=FinalPoint(1,2);%Assign the "FinalPoint" Y value to "Ypoint" variable
  if Ypoint<0%Creation of an if statement to check if "Ypoint" is smaller than 0
    Ypoint=Ypoint*-1;%If "Ypoint" is smaller than 0 it is multiplied by -1
  endif%Close the if statement
  Theta=asin(Ypoint/sqrt(power(Xpoint,2)+power(Ypoint,2)));%Creation of "Theta" variable and assign the value of the slope angle of the line through the center and the current vector's head
  a=[0 0];%Creation the "a" (acceleration) vector and assign the value of (0,0)
  if (Theta<=deg2rad(67.5))&&(Theta>=deg2rad(22.5))%Creation of an if statement to check if "Theta" is smaller or equal to 67.5deg and smaller or equal to 22.5deg
    a=[1 1];%In case "Theta" is bigger or equal to 22.5deg and smaller or equal to 67.5deg, "a" is assigned the value of (1,1)
  endif%Close the if statement
  if Theta<deg2rad(22.5)%Creation of an if statement to check if "Theta" is smaller than 22.5deg
    a=[1 0];%In case "Theta" is smaller than 22.5deg, "a" is assigned the value of (1,0)
  endif%Close the if statement
  if Theta>deg2rad(67.5)%Creation of an if statement to check if "Theta" is bigger than 67.5deg
    a=[0 1];%In case "Theta" is bigger than 67.5deg, "a" is assigned the value of (0,1)
  endif%Close the if statement
  if FinalPoint(1,2)>0%Creation of an if statement to check if the Y value of "FinalPoint" is bigger than 0
    a(1,2)=a(1,2)*-1;%In case the Y value of "FinalPoint" is bigger than 0, Y component of the acceleration is multiplied by -1  
  endif%Close the if statement
  if FinalPoint(1,1)>0%Creation of an if statement to check if the X value of "FinalPoint" is bigger than 0
    a(1,1)=a(1,1)*-1;%In case the X value of "FinalPoint" is bigger than 0, X component of the acceleration is multiplied by -1
  endif%Close the if statement
  longitudes=[longitudes;FinalPoint(1,1)-InitialPoint(1,1) FinalPoint(1,2)-InitialPoint(1,2)];%Add the X and Y longitudes vectorized to the "longitudes" variable
  points=[points;FinalPoint];%Add "FinalPoint" to the "points" variable
  accelerations=[accelerations;a];%Add "a" to the "accelerations" variable
  angles=[angles;Theta];%Add "Theta" to the "angles" variable 
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
  NewPoint=[2*FinalPoint(1,1)-InitialPoint(1,1)+a(1,1) 2*FinalPoint(1,2)-InitialPoint(1,2)+a(1,2)];%Create "NewPoint" variable and assign the value of the coordinates of the new point generated by cloning the vector and submitting it to the acceleration
  InitialPoint=FinalPoint;%Update "InitialPoint" by assigning the value of "FinalPoint"
  FinalPoint=NewPoint;%Update "FinalPoint" by assigning the value of "NewPoint"
endfor%End the for loop
axis([1.1*MinXPoint 1.1*MaxXPoint 1.1*MinYPoint 1.1*MaxYPoint]);
%check if orbit is repeating itself
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
file=fopen("Stuff.txt",'w');%Create "file" variable and open "Stuff.txt"
fprintf(file,"Points Accelerations Angles Longitudes\n");%Print the titles of the variables in the "Stuff.txt" file
for i=1:totalValues%Creation of a for loop to read all the data stored in the variables
  fprintf(file,"(%d,%d)    (%d,%d)    %d    (%d,%d)\n",pointsDef(i,1),pointsDef(i,2),accelerationsDef(i,1),accelerationsDef(i,2),anglesDef(i),longitudesDef(i,1),longitudesDef(i,2));%Print on the file all the different points and variables nice formatted
endfor%End the for loop
fclose(file);%Close the "Stuff.txt" file
%print other stuff
file=fopen("Stuff2.txt","w");
fprintf(file,"Pi-1        Pi        Vi        Ai        Ti\n");
for i=2:totalValues
  fprintf(file,"(%d,%d)    (%d,%d)    (%d,%d)    (%d,%d)    %d\n",pointsDef(i-1,1),pointsDef(i-1,2),pointsDef(i,1),pointsDef(i,2),longitudesDef(i,1),longitudesDef(i,2),accelerationsDef(i,1),accelerationsDef(i,2),anglesDef(i));
endfor
fclose(file);  
%Representation
for i=1:totalValues-1
  hold on;%Maintain the former plots in the screen
  plot([points(i,1) points(i+1,1)],[points(i,2) points(i+1,2)],'k')%Represent the vector between "FinalPoint" and "NewPoint"
endfor