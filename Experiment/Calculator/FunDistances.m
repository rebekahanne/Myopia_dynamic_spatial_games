function [DistanceMatrix] = FunDistances(Size,PlayerNumber,ListOfPositions,Metric)

Height = Size(1);
Width = Size(2);

if Metric == 'L1'
    for ii=1:Height
        for jj=1:Width
            DistanceMatrix(ii,jj)=abs(ListOfPositions(PlayerNumber,1)-ii)...
                +abs(ListOfPositions(PlayerNumber,2)-jj);
        end
    end
    
elseif Metric == 'L2'
    for ii=1:Height
        for jj=1:Width
            DistanceMatrix(ii,jj)=sqrt((ListOfPositions(PlayerNumber,1)-ii)^2+(ListOfPositions(PlayerNumber,2)-jj)^2);
        end
    end
end

end

% for i=1:n
%     for j=1:Width
%         for k=1:Height
%         Distances(j,k,i)=abs(ListOfPositions(i,1)-j)...
%             +abs(ListOfPositions(i,2)-k);
%         end
%     end
% end