function [Areas, ListOfPositionsCurrent, failed] = FunCalculatorIt(player1x, player1y, player2x, player2y, player3x, player3y, player4x, player4y, player5x, player5y)

Size = [21,21];
Height = Size(1);
Width = Size(2);
Metric = 'L1';

ListOfPositionsCurrent = zeros(13,2);
Areas = zeros(1,13);
failed = false;

player1x = str2num(player1x);
player2x = str2num(player2x);
player3x = str2num(player3x);
player4x = str2num(player4x);
player5x = str2num(player5x);

player1y = upper(player1y);
player2y = upper(player2y);
player3y = upper(player3y);
player4y = upper(player4y);
player5y = upper(player5y);

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

ListOfPositionsCurrent(1,1) = player1x;
ListOfPositionsCurrent(1,2) = player1ynum;
ListOfPositionsCurrent(2,1) = player2x;
ListOfPositionsCurrent(2,2) = player2ynum;
ListOfPositionsCurrent(3,1) = player3x;
ListOfPositionsCurrent(3,2) = player3ynum;
ListOfPositionsCurrent(4,1) = player4x;
ListOfPositionsCurrent(4,2) = player4ynum;
ListOfPositionsCurrent(5,1) = player5x;
ListOfPositionsCurrent(5,2) = player5ynum;

for ii=1:13
    for jj=1:13
        if ii == jj
            continue;
        elseif (ListOfPositionsCurrent(ii,1) == ListOfPositionsCurrent(jj,1)) && (ListOfPositionsCurrent(ii,2) == ListOfPositionsCurrent(jj,2))
            errordlg('Please do not place more than one computer or player on a space.','Input Error')
            failed = true;
            return;
        end
    end
end
% Create distances of current state
Distances = zeros(Height,Width);

for nn=1:13
    Distances(:,:,nn) = FunDistances(Size,nn,ListOfPositionsCurrent,Metric);   
end

% Create territories of current state   
Territories = cell(Height,Width);

for ii=1:Height
    for jj=1:Width
        I=find(Distances(ii,jj,:)==min(Distances(ii,jj,:)));
        Territories(ii,jj)={I};
    end
end  

% Scoring
for nn=1:13
    Areas(1,nn) = FunCountTerritories(nn, Territories);
end

 %% TERRITORIES MAP
    
% Take territories and convert it to a matrix with zeros for all
% shared territories
CleanTerritories = Territories;

for ii=1:Height
    for jj=1:Width
        if cellfun(@length, Territories(ii,jj)) > 1
             % Rewrite with flag to leave for loop
             if ~(cellfun(@(x)ismember(1,x),Territories(ii,jj))) && ~(cellfun(@(x)ismember(2,x),Territories(ii,jj))) && ~(cellfun(@(x)ismember(3,x),Territories(ii,jj))) && ~(cellfun(@(x)ismember(4,x),Territories(ii,jj))) && ~(cellfun(@(x)ismember(5,x),Territories(ii,jj)))
                 CleanTerritories(ii,jj)={7};
             else
                 CleanTerritories(ii,jj)={0};
             end
        end
    end 
end

CleanTerritories = cell2mat(CleanTerritories);

% Assign the current locations of the players to a unique number in
% order to color code
CleanTerritories(ListOfPositionsCurrent(1,1), ListOfPositionsCurrent(1,2)) = 14;
CleanTerritories(ListOfPositionsCurrent(2,1), ListOfPositionsCurrent(2,2)) = 15;
CleanTerritories(ListOfPositionsCurrent(3,1), ListOfPositionsCurrent(3,2)) = 16;
CleanTerritories(ListOfPositionsCurrent(4,1), ListOfPositionsCurrent(4,2)) = 17;
CleanTerritories(ListOfPositionsCurrent(5,1), ListOfPositionsCurrent(5,2)) = 18;

FunCreateFigure(ListOfPositionsCurrent, CleanTerritories)
        
end