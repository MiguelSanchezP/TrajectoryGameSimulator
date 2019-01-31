points=[];

printf("Centre's X: ");
variableXtemp=input(' ');
printf("Centre's Y: ");
variableYtemp=input(' ');
centre=[variableXtemp variableYtemp];

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