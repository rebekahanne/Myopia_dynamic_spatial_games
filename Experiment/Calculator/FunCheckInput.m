function [failed] = FunCheckInput(player1x, player1y, player2x, player2y, player3x, player3y, player4x, player4y, player5x, player5y)

% x values must be an integer between 1 and 21
% y values must be a letter between A and U (lower and upper case fine)\

% We check for colocations in FunCalculatorIt, convert the y values to
% upper case, and replace the y values with numbers

failed = false;

player1x = str2num(player1x);
player2x = str2num(player2x);
player3x = str2num(player3x);
player4x = str2num(player4x);
player5x = str2num(player5x);

if isempty(player1x) || isempty(player2x) || isempty(player3x) || isempty(player4x) || isempty(player5x)
    failed = true;
    errordlg('Please enter an integer between 1 and 21.','Input Error')
    return
end


AlphabetUpper = 'ABCDEFGHIJKLMNOPQRSTU';
AlphabetLower = 'abcdefghijklmnopqrstu';

if player1x > 21 | player1x < 1 | player2x > 21 | player2x < 1 | player3x > 21 | player3x < 1 | player4x > 21 | player4x < 1 | player5x > 21 | player5x < 1
    errordlg('Please enter an integer between 1 and 21.','Input Error')
    failed = true;
    return
end
  
if fix(player1x)-player1x==0
	failed = false;
else
    errordlg('Please enter an integer between 1 and 21.','Input Error')
    failed = true;
    return
end

if fix(player1x)-player1x==0
	failed = false;
else
    errordlg('Please enter an integer between 1 and 21.','Input Error')
    failed = true;
    return
end

if fix(player2x)-player2x==0
	failed = false;
else
    errordlg('Please enter an integer between 1 and 21.','Input Error')
    failed = true;
    return
end

if fix(player3x)-player3x==0
	failed = false;
else
    errordlg('Please enter an integer between 1 and 21.','Input Error')
    failed = true;
    return
end

if fix(player4x)-player4x==0
	failed = false;
else
    errordlg('Please enter an integer between 1 and 21.','Input Error')
    failed = true;
    return
end

if fix(player5x)-player5x==0
	failed = false;
else
    errordlg('Please enter an integer between 1 and 21.','Input Error')
    failed = true;
    return
end

if (length(player1y)> 1) || (~(any(ismember(AlphabetUpper,player1y))) && ~(any(ismember(AlphabetLower,player1y))))
    errordlg('Please enter a letter between A and U.','Input Error')
    failed = true;
    return
end

if (length(player2y)> 1) || (~(any(ismember(AlphabetUpper,player2y))) && ~(any(ismember(AlphabetLower,player2y))))
    errordlg('Please enter a letter between A and U.','Input Error')
    failed = true;
    return
end

if (length(player3y)> 1) || (~(any(ismember(AlphabetUpper,player3y))) && ~(any(ismember(AlphabetLower,player3y))))
    errordlg('Please enter a letter between A and U.','Input Error')
    failed = true;
    return
end

if (length(player4y)> 1) || (~(any(ismember(AlphabetUpper,player4y))) && ~(any(ismember(AlphabetLower,player4y))))
    errordlg('Please enter a letter between A and U.','Input Error')
    failed = true;
    return
end

if (length(player5y)> 1) || (~(any(ismember(AlphabetUpper,player5y))) && ~(any(ismember(AlphabetLower,player5y))))
    errordlg('Please enter a letter between A and U.','Input Error')
    failed = true;
    return
end

end