% Assumes there are 5 Player and 8 Computers
function [ListOfPositionsCurrent] = FunCreateListOfPositions(player1x, player1y, player2x, player2y, player3x, player3y, player4x, player4y, player5x, player5y)

ListOfPositionsCurrent = zeros(N+Ncomputers,2);

Alphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
Computers = [1,1;21,1;11,1;1,21;1,11;21,11;11,21;21,21];

ListOfPositionsCurrent(6,:) = Computers(1,:);
ListOfPositionsCurrent(7,:) = Computers(2,:);
ListOfPositionsCurrent(8,:) = Computers(3,:);
ListOfPositionsCurrent(9,:) = Computers(4,:);
ListOfPositionsCurrent(10,:) = Computers(5,:);
ListOfPositionsCurrent(11,:) = Computers(6,:);
ListOfPositionsCurrent(12,:) = Computers(7,:);
ListOfPositionsCurrent(13,:) = Computers(8,:);

player1ynum = find(Alphabet==player1y,1);
player2ynum = find(Alphabet==player2y,1);
player3ynum = find(Alphabet==player3y,1);
player4ynum = find(Alphabet==player4y,1);
player5ynum = find(Alphabet==player5y,1);

ListOfPositionsCurrrent(1,1) = player1x;
ListOfPositionsCurrrent(1,2) = player1ynum;
ListOfPositionsCurrrent(2,1) = player2x;
ListOfPositionsCurrrent(2,2) = player2ynum;
ListOfPositionsCurrrent(3,1) = player3x;
ListOfPositionsCurrrent(3,2) = player3ynum;
ListOfPositionsCurrrent(4,1) = player4x;
ListOfPositionsCurrrent(4,2) = player4ynum;
ListOfPositionsCurrrent(5,1) = player5x;
ListOfPositionsCurrrent(5,2) = player5ynum;

end