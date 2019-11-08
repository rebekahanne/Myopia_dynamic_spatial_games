function potareas

   % Set random seed
   rng(1);

   global player1xcoord
   global player1ycoord
   global player2xcoord
   global player2ycoord
   global player3xcoord
   global player3ycoord
   global player4xcoord
   global player4ycoord
   global player5xcoord
   global player5ycoord

   global sessionNumber 
       
   playerlocationscell = {'Locations'};
   currentplayercell = {'Current'; 'Player'};
   
   % Add the UI components
   hs = addcomponents;
      
   % Make figure visible after adding components
   hs.fig.Visible = 'on';
   
   function hs = addcomponents
       
       % Create settings structure to pass to functions for generality
        hs.settings.Alphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
        hs.settings.N = 5;
        hs.settings.Ncomputers = 8;
        hs.settings.Size = [21,21];
        hs.settings.Height = hs.settings.Size(1);
        hs.settings.Width = hs.settings.Size(2);
        hs.settings.Metric = 'L1';
        hs.settings.Computers = [1,1;21,1;11,1;1,21;1,11;21,11;11,21;21,21];
        hs.settings.sessionNumber = sessionNumber;
       
        chosen = randi(hs.settings.N);
        
        ListOfPositions = zeros(hs.settings.N+hs.settings.Ncomputers, 2);
        ListOfPositions(1,1) = player1xcoord;
        ListOfPositions(2,1) = player2xcoord;
        ListOfPositions(3,1) = player3xcoord;
        ListOfPositions(4,1) = player4xcoord;
        ListOfPositions(5,1) = player5xcoord;        
        ListOfPositions(1,2) = player1ycoord;
        ListOfPositions(2,2) = player2ycoord;
        ListOfPositions(3,2) = player3ycoord;
        ListOfPositions(4,2) = player4ycoord;
        ListOfPositions(5,2) = player5ycoord;    
        ListOfPositions(6,:) = hs.settings.Computers(1,:);
        ListOfPositions(7,:) = hs.settings.Computers(2,:);
        ListOfPositions(8,:) = hs.settings.Computers(3,:);
        ListOfPositions(9,:) = hs.settings.Computers(4,:);
        ListOfPositions(10,:) = hs.settings.Computers(5,:);
        ListOfPositions(11,:) = hs.settings.Computers(6,:);
        ListOfPositions(12,:) = hs.settings.Computers(7,:);
        ListOfPositions(13,:) = hs.settings.Computers(8,:);
        
        % Create distances of current state
        Distances = zeros(hs.settings.Height,hs.settings.Width);
        for nn=1:hs.settings.N+hs.settings.Ncomputers
            Distances(:,:,nn) = FunDistances(hs.settings.Size,nn,ListOfPositions,hs.settings.Metric);   
        end

        % Create territories of current state   
        Territories = cell(hs.settings.Height,hs.settings.Width);   
        for ii=1:hs.settings.Height
            for jj=1:hs.settings.Width
                I=find(Distances(ii,jj,:)==min(Distances(ii,jj,:)));
                Territories(ii,jj)={I};
            end
        end

        % Create list of places to move to (including origin)
        IndMoveOptions = find(Distances(:,:,chosen)<=1);

        % When a player is on the boundary, five move options will not be
        % generated because the search would leave the grid. We insert the
        % appropriate number of options as 0 for the missing entries.
        if ListOfPositions(chosen, 1) == 1 
            IndMoveOptions = [IndMoveOptions(1); 0; IndMoveOptions(2:4)];
        end

        if ListOfPositions(chosen, 2) == 1 
            IndMoveOptions = [0; IndMoveOptions(1:4)];
        end

        if ListOfPositions(chosen, 1) == 21 
            IndMoveOptions = [IndMoveOptions(1:3); 0; IndMoveOptions(4)];
        end

        if ListOfPositions(chosen, 2) == 21 
            IndMoveOptions = [IndMoveOptions(1:4); 0];
        end

        % MoveOptions is set to have 5 entries; we set entries that are not
        % feasible because of the bounds of the grid or the location of
        % another player to 0, and these options are not selectable in the
        % GUI
        MoveOptions = zeros(5,2);
        for kk=1:length(IndMoveOptions)
           [MoveOptions(kk,1),MoveOptions(kk,2)]=ind2sub([hs.settings.Height,hs.settings.Width],IndMoveOptions(kk));
        end

        % Check for potential collisions with other players
        for ii=1:5
           for jj= 1:hs.settings.N + hs.settings.Ncomputers
            if jj == chosen
                continue
            elseif MoveOptions(ii,1) == ListOfPositions(jj,1) && MoveOptions(ii,2) == ListOfPositions(jj,2)
                MoveOptions(ii,1) = 0;
                MoveOptions(ii,2) = 0;           
            end
           end
        end       

        % TERRITORIES MAP    
        % Take territories and convert it to a matrix with zeros for all
        % shared territories
        CleanTerritories = Territories;

        for ii=1:hs.settings.Height
            for jj=1:hs.settings.Width
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
        CleanTerritories(ListOfPositions(1,1), ListOfPositions(1,2)) = 14;
        CleanTerritories(ListOfPositions(2,1), ListOfPositions(2,2)) = 15;
        CleanTerritories(ListOfPositions(3,1), ListOfPositions(3,2)) = 16;
        CleanTerritories(ListOfPositions(4,1), ListOfPositions(4,2)) = 17;
        CleanTerritories(ListOfPositions(5,1), ListOfPositions(5,2)) = 18;

        % Assign the potential move options a number that will correspond to a
        % different shade of each player's color
        for ii=1:5
            if MoveOptions(ii,1) ~= 0
                if ii == 3
                    continue
                end
                CleanTerritories(MoveOptions(ii,1), MoveOptions(ii,2)) = 19;
            end
        end

        % Colors for Move Options
        green_m = [34/255 139/255 34/255];
        orange_m = [1 127/255 80/255];
        purple_m = [148/255 0 211/255];
        blue_m = [65/255 105/255 1];
        red_m = [220/255 20/255 60/255];
    
        % Assign a color for the move options to be highlighted in (dependent
        % on the color)
        % Could rewrite with flag to leave for loop
        if chosen == 1
            moveoptionscolor = green_m;
        end
        if chosen == 2
            moveoptionscolor = orange_m;
        end
        if chosen == 3
            moveoptionscolor = purple_m;
        end
        if chosen == 4
            moveoptionscolor = blue_m;
        end
        if chosen == 5
            moveoptionscolor = red_m;
        end

        % Create the image file of the current state
        FunCreateFigure(ListOfPositions, CleanTerritories, moveoptionscolor, MoveOptions)
    
       % add components, save handles in a struct
        hs.fig = figure( 'units','normalized', ...
            'Name', 'Main Console','NumberTitle','off', 'MenuBar', 'none',...
            'OuterPosition', [0 0.03 1 .99]);                       
        hbox = uiextras.HBox( 'Parent', hs.fig, 'Padding', 20);
        vbox1 = uiextras.VBox( 'Parent', hbox);       
        hs.currentplayertext = uicontrol('Parent',vbox1,'Style','text',...
                'String',currentplayercell, 'FontWeight', 'bold', 'FontSize', 32.0, 'ForegroundColor', 'b');
        hs.currentplayernum = uicontrol('Parent',vbox1,'Style','text',...
                'String',chosen, 'FontSize', 32.0);
        hs.playerlocations = uicontrol('Parent',vbox1,'Style','text',...
                'String',playerlocationscell, 'FontWeight', 'bold', 'FontSize', 32.0, 'ForegroundColor', 'b');
        hbox1 = uiextras.HBox( 'Parent', vbox1);
        vbox11 = uiextras.VBox( 'Parent', hbox1);
        hs.player1 = uicontrol('Parent',vbox11,'Style','text',...
                'String','1:', 'FontSize', 20,'Tag','player1', 'ForegroundColor', 'b');
        hs.player2 = uicontrol('Parent',vbox11,'Style','text',...
                'String','2:', 'FontSize', 20,'Tag','player2', 'ForegroundColor', 'b');
        hs.player3 = uicontrol('Parent',vbox11,'Style','text',...
                'String','3:', 'FontSize', 20,'Tag','player3', 'ForegroundColor', 'b');
        hs.player4 = uicontrol('Parent',vbox11,'Style','text',...
                'String','4:', 'FontSize', 20,'Tag','player4', 'ForegroundColor', 'b');   
        hs.player5 = uicontrol('Parent',vbox11,'Style','text',...
                'String','5:', 'FontSize', 20,'Tag','player5', 'ForegroundColor', 'b');
        
        vbox12 = uiextras.VBox( 'Parent', hbox1);
        hs.loc12 = uicontrol('Parent',vbox12,'Style','text',...
                'String','1:', 'FontSize', 20,'Tag','player1');
        hs.loc22 = uicontrol('Parent',vbox12,'Style','text',...
                'String','1:', 'FontSize', 20,'Tag','player1');
        hs.loc32 = uicontrol('Parent',vbox12,'Style','text',...
                'String','1:', 'FontSize', 20,'Tag','player1');
        hs.loc42 = uicontrol('Parent',vbox12,'Style','text',...
                'String','1:', 'FontSize', 20,'Tag','player1');
        hs.loc52 = uicontrol('Parent',vbox12,'Style','text',...
                'String','1:', 'FontSize', 20,'Tag','player1');
            
        vbox13 = uiextras.VBox( 'Parent', hbox1);        
        hs.loc11 = uicontrol('Parent',vbox13,'Style','text',...
                'String','1:', 'FontSize', 20,'Tag','player1');              
        hs.loc21 = uicontrol('Parent',vbox13,'Style','text',...
                'String','1:', 'FontSize', 20,'Tag','player1');         
        hs.loc31 = uicontrol('Parent',vbox13,'Style','text',...
                'String','1:', 'FontSize', 20,'Tag','player1');            
        hs.loc41 = uicontrol('Parent',vbox13,'Style','text',...
                'String','1:', 'FontSize', 20,'Tag','player1');                                        
        hs.loc51 = uicontrol('Parent',vbox13,'Style','text',...
                'String','1:', 'FontSize', 20,'Tag','player1');       
        
        set(hs.loc11,'String',ListOfPositions(1,1));
        set(hs.loc21,'String',ListOfPositions(2,1));
        set(hs.loc31,'String',ListOfPositions(3,1));
        set(hs.loc41,'String',ListOfPositions(4,1));
        set(hs.loc51,'String',ListOfPositions(5,1));

        set(hs.loc12,'String',hs.settings.Alphabet(ListOfPositions(1,2)));
        set(hs.loc22,'String',hs.settings.Alphabet(ListOfPositions(2,2)));
        set(hs.loc32,'String',hs.settings.Alphabet(ListOfPositions(3,2)));
        set(hs.loc42,'String',hs.settings.Alphabet(ListOfPositions(4,2)));
        set(hs.loc52,'String',hs.settings.Alphabet(ListOfPositions(5,2)));

        set(hs.currentplayernum,'String',chosen);   
        
        hbox2 = uiextras.HBox( 'Parent', vbox1, 'Padding', 5);    
       
        vbox21 = uiextras.VBox( 'Parent', hbox2);
        
        hs.nothing1 = uicontrol( 'Parent', vbox21);
        hs.left = uicontrol( 'Parent', vbox21, ...
             'String', 'L', 'FontSize', 20.0, 'Tag','left', 'Callback',@left_Callback);
        hs.nothing2 = uicontrol( 'Parent', vbox21);
        
        vbox22 = uiextras.VBox( 'Parent', hbox2);
        
        hs.up = uicontrol( 'Parent', vbox22, ...
             'String', 'U', 'FontSize', 20.0, 'Tag','up', 'Callback',@up_Callback);
        hs.stay = uicontrol( 'Parent', vbox22, ...
             'String', 'S', 'FontSize', 20.0, 'Tag','stay', 'Callback',@stay_Callback);
        hs.down = uicontrol( 'Parent', vbox22, ...
             'String', 'D', 'FontSize', 20.0, 'Tag','down', 'Callback',@down_Callback);
        
        vbox23 = uiextras.VBox( 'Parent', hbox2);
        
        hs.nothing3 = uicontrol( 'Parent', vbox23);
        hs.right = uicontrol( 'Parent', vbox23, ...
             'String', 'R', 'FontSize', 20.0, 'Tag','right', 'Callback',@right_Callback);
        hs.nothing4 = uicontrol( 'Parent', vbox23);            
        
        hbox3 = uiextras.VBox( 'Parent', vbox1);
        
        hs.right = uicontrol( 'Parent', hbox3, ...
             'String', 'End Session', 'FontSize', 20.0, 'Tag','end', 'Callback',@quit_Callback);
        
        
        hs.axes1 = axes( 'Parent', hbox, ...
            'ActivePositionProperty', 'OuterPosition' );
        hs.axes1.Visible = 'off';
        
        hbox.Sizes = [250 -1];
        vbox1.Sizes = [120 60 80 -10 -3 -1];
          
        axes(hs.axes1)
        set(hs.axes1,'Unit','normalized','Position',[.1 0 1 .99])
        imshow('screen.png');
    
        guidata(hs.fig,hs)               
        
   end

end
    
% --- Executes on button press in left.
function left_Callback(hObject, eventdata, handles)
% hObject    handle to left (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    
    % Get handles structure
    handles = guidata(gcbo);
        
    BestMove = zeros(handles.settings.N+handles.settings.Ncomputers,2);
    
    % Get the current LOP from the handles structure
    ListOfPositions = MakeListOfPositions;
     
    % Get the current player from the handles structure  
    chosen = str2double(handles.currentplayernum.String);
    
    % Get the move options of the current player
    moveoptions = GetMoveOptions(chosen, ListOfPositions);       
    
    % If the move option for this button is valid (i.e. non-zero)
    if moveoptions(1,1) ~= 0
        
        % Store the chosen move
        xcoordinate = moveoptions(1,1);
        ycoordinate = moveoptions(1,2);    
        BestMove(chosen,1) = xcoordinate;
        BestMove(chosen,2) = ycoordinate;        
        MoveChosen = BestMove(chosen,:);
        
        % Keep other players in the same positions
        for nnn=1:handles.settings.N
            if nnn == chosen
                continue
            end
            BestMove(nnn,:) = ListOfPositions(nnn,:);
        end

        % Keep the computers in the same positions
        for nnn=handles.settings.N+1:handles.settings.N+handles.settings.Ncomputers
            BestMove(nnn,:)= handles.settings.Computers(nnn-handles.settings.N,:);
        end

        % Create a matrix of the current state
        NewStateMat = zeros(handles.settings.Height, handles.settings.Width);
        for nnn=1:handles.settings.N+handles.settings.Ncomputers
            NewStateMat(BestMove(nnn,1),BestMove(nnn,2)) = nnn;
        end
                
        CurrentStateMatrix = NewStateMat;
        ListOfPositions = BestMove;       
          
        calctime = clock;       

        save(strcat('./Data/Console_',strcat(num2str(handles.settings.sessionNumber)),'_',mat2str(calctime),'.mat'),'ListOfPositions','CurrentStateMatrix','chosen','MoveChosen','calctime') 

        update(ListOfPositions)
    
    end
end

% --- Executes on button press in up.
function up_Callback(hObject, eventdata, handles)
% hObject    handle to up (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    % Get handles structure
    handles = guidata(gcbo);
        
    BestMove = zeros(handles.settings.N+handles.settings.Ncomputers,2);
    
    % Get the current LOP from the handles structure
    ListOfPositions = MakeListOfPositions;
     
    % Get the current player from the handles structure  
    chosen = str2double(handles.currentplayernum.String);
    
    % Get the move options of the current player
    moveoptions = GetMoveOptions(chosen, ListOfPositions);       
    
    % If the move option for this button is valid (i.e. non-zero)
    if moveoptions(2,1) ~= 0
        
        % Store the chosen move
        xcoordinate = moveoptions(2,1);
        ycoordinate = moveoptions(2,2);    
        BestMove(chosen,1) = xcoordinate;
        BestMove(chosen,2) = ycoordinate;        
        MoveChosen = BestMove(chosen,:);
        
        % Keep other players in the same positions
        for nnn=1:handles.settings.N
            if nnn == chosen
                continue
            end
            BestMove(nnn,:) = ListOfPositions(nnn,:);
        end

        % Keep the computers in the same positions
        for nnn=handles.settings.N+1:handles.settings.N+handles.settings.Ncomputers
            BestMove(nnn,:)= handles.settings.Computers(nnn-handles.settings.N,:);
        end

        % Create a matrix of the current state
        NewStateMat = zeros(handles.settings.Height, handles.settings.Width);
        for nnn=1:handles.settings.N+handles.settings.Ncomputers
            NewStateMat(BestMove(nnn,1),BestMove(nnn,2)) = nnn;
        end
                
        CurrentStateMatrix = NewStateMat;
        ListOfPositions = BestMove;       
          
        calctime = clock;       

        save(strcat('./Data/Console_',strcat(num2str(handles.settings.sessionNumber)),'_',mat2str(calctime),'.mat'),'ListOfPositions','CurrentStateMatrix','chosen','MoveChosen','calctime') 

        update(ListOfPositions)
    
    end
end

% --- Executes on button press in stay.
function stay_Callback(hObject, eventdata, handles)
% hObject    handle to stay (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    % Get handles structure
    handles = guidata(gcbo);
        
    BestMove = zeros(handles.settings.N+handles.settings.Ncomputers,2);
    
    % Get the current LOP from the handles structure
    ListOfPositions = MakeListOfPositions;
     
    % Get the current player from the handles structure  
    chosen = str2double(handles.currentplayernum.String);
    
    % Get the move options of the current player
    moveoptions = GetMoveOptions(chosen, ListOfPositions);       
    
    % If the move option for this button is valid (i.e. non-zero)
    if moveoptions(3,1) ~= 0
        
        % Store the chosen move
        xcoordinate = moveoptions(3,1);
        ycoordinate = moveoptions(3,2);    
        BestMove(chosen,1) = xcoordinate;
        BestMove(chosen,2) = ycoordinate;        
        MoveChosen = BestMove(chosen,:);
        
        % Keep other players in the same positions
        for nnn=1:handles.settings.N
            if nnn == chosen
                continue
            end
            BestMove(nnn,:) = ListOfPositions(nnn,:);
        end

        % Keep the computers in the same positions
        for nnn=handles.settings.N+1:handles.settings.N+handles.settings.Ncomputers
            BestMove(nnn,:)= handles.settings.Computers(nnn-handles.settings.N,:);
        end

        % Create a matrix of the current state
        NewStateMat = zeros(handles.settings.Height, handles.settings.Width);
        for nnn=1:handles.settings.N+handles.settings.Ncomputers
            NewStateMat(BestMove(nnn,1),BestMove(nnn,2)) = nnn;
        end
                
        CurrentStateMatrix = NewStateMat;
        ListOfPositions = BestMove;       
          
        calctime = clock;       

        save(strcat('./Data/Console_',strcat(num2str(handles.settings.sessionNumber)),'_',mat2str(calctime),'.mat'),'ListOfPositions','CurrentStateMatrix','chosen','MoveChosen','calctime') 

        update(ListOfPositions)
    
    end
end

% --- Executes on button press in down.
function down_Callback(hObject, eventdata, handles)
% hObject    handle to down (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    % Get handles structure
    handles = guidata(gcbo);
        
    BestMove = zeros(handles.settings.N+handles.settings.Ncomputers,2);
    
    % Get the current LOP from the handles structure
    ListOfPositions = MakeListOfPositions;
     
    % Get the current player from the handles structure  
    chosen = str2double(handles.currentplayernum.String);
    
    % Get the move options of the current player
    moveoptions = GetMoveOptions(chosen, ListOfPositions);       
    
    % If the move option for this button is valid (i.e. non-zero)
    if moveoptions(4,1) ~= 0
        
        % Store the chosen move
        xcoordinate = moveoptions(4,1);
        ycoordinate = moveoptions(4,2);    
        BestMove(chosen,1) = xcoordinate;
        BestMove(chosen,2) = ycoordinate;        
        MoveChosen = BestMove(chosen,:);
        
        % Keep other players in the same positions
        for nnn=1:handles.settings.N
            if nnn == chosen
                continue
            end
            BestMove(nnn,:) = ListOfPositions(nnn,:);
        end

        % Keep the computers in the same positions
        for nnn=handles.settings.N+1:handles.settings.N+handles.settings.Ncomputers
            BestMove(nnn,:)= handles.settings.Computers(nnn-handles.settings.N,:);
        end

        % Create a matrix of the current state
        NewStateMat = zeros(handles.settings.Height, handles.settings.Width);
        for nnn=1:handles.settings.N+handles.settings.Ncomputers
            NewStateMat(BestMove(nnn,1),BestMove(nnn,2)) = nnn;
        end
                
        CurrentStateMatrix = NewStateMat;
        ListOfPositions = BestMove;       
          
        calctime = clock;       

        save(strcat('./Data/Console_',strcat(num2str(handles.settings.sessionNumber)),'_',mat2str(calctime),'.mat'),'ListOfPositions','CurrentStateMatrix','chosen','MoveChosen','calctime') 

        update(ListOfPositions)
    
    end
end

% --- Executes on button press in right.
function right_Callback(hObject, eventdata, handles)
% hObject    handle to right (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    % Get handles structure
    handles = guidata(gcbo);
        
    BestMove = zeros(handles.settings.N+handles.settings.Ncomputers,2);
    
    % Get the current LOP from the handles structure
    ListOfPositions = MakeListOfPositions;
     
    % Get the current player from the handles structure  
    chosen = str2double(handles.currentplayernum.String);
    
    % Get the move options of the current player
    moveoptions = GetMoveOptions(chosen, ListOfPositions);       
    
    % If the move option for this button is valid (i.e. non-zero)
    if moveoptions(5,1) ~= 0
        
        % Store the chosen move
        xcoordinate = moveoptions(5,1);
        ycoordinate = moveoptions(5,2);    
        BestMove(chosen,1) = xcoordinate;
        BestMove(chosen,2) = ycoordinate;        
        MoveChosen = BestMove(chosen,:);
        
        % Keep other players in the same positions
        for nnn=1:handles.settings.N
            if nnn == chosen
                continue
            end
            BestMove(nnn,:) = ListOfPositions(nnn,:);
        end

        % Keep the computers in the same positions
        for nnn=handles.settings.N+1:handles.settings.N+handles.settings.Ncomputers
            BestMove(nnn,:)= handles.settings.Computers(nnn-handles.settings.N,:);
        end

        % Create a matrix of the current state
        NewStateMat = zeros(handles.settings.Height, handles.settings.Width);
        for nnn=1:handles.settings.N+handles.settings.Ncomputers
            NewStateMat(BestMove(nnn,1),BestMove(nnn,2)) = nnn;
        end
                
        CurrentStateMatrix = NewStateMat;
        ListOfPositions = BestMove;       
          
        calctime = clock;       

        save(strcat('./Data/Console_',strcat(num2str(handles.settings.sessionNumber)),'_',mat2str(calctime),'.mat'),'ListOfPositions','CurrentStateMatrix','chosen','MoveChosen','calctime') 

        update(ListOfPositions)
    
    end
   
end

% --- Executes on button press in quit.
function quit_Callback(hObject, eventdata, handles)
% hObject    handle to quit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    close all;
    
end

function update(ListOfPositions)

    % Colors for Move Options
    green_m = [34/255 139/255 34/255];
    orange_m = [1 127/255 80/255];
    purple_m = [148/255 0 211/255];
    blue_m = [65/255 105/255 1];
    red_m = [220/255 20/255 60/255];
    
    handles = guidata(gcbo);       
    
    % Choose next players
    chosen = randi(handles.settings.N);
    
    % Update the LOP on screen
    set(handles.loc11,'String',ListOfPositions(1,1));
    set(handles.loc21,'String',ListOfPositions(2,1));
    set(handles.loc31,'String',ListOfPositions(3,1));
    set(handles.loc41,'String',ListOfPositions(4,1));
    set(handles.loc51,'String',ListOfPositions(5,1));

    set(handles.loc12,'String',handles.settings.Alphabet(ListOfPositions(1,2)));
    set(handles.loc22,'String',handles.settings.Alphabet(ListOfPositions(2,2)));
    set(handles.loc32,'String',handles.settings.Alphabet(ListOfPositions(3,2)));
    set(handles.loc42,'String',handles.settings.Alphabet(ListOfPositions(4,2)));
    set(handles.loc52,'String',handles.settings.Alphabet(ListOfPositions(5,2)));

    % Update the current player number on screen
    set(handles.currentplayernum,'String',chosen); 
       
    % Create distances of current state
    Distances = zeros(handles.settings.Height,handles.settings.Width);
    for nn=1:handles.settings.N+handles.settings.Ncomputers
        Distances(:,:,nn) = FunDistances(handles.settings.Size,nn,ListOfPositions,handles.settings.Metric);   
    end
    
    % Create territories of current state   
    Territories = cell(handles.settings.Height,handles.settings.Width);   
    for ii=1:handles.settings.Height
        for jj=1:handles.settings.Width
            I=find(Distances(ii,jj,:)==min(Distances(ii,jj,:)));
            Territories(ii,jj)={I};
        end
    end

    % Create list of places to move to (including origin)
    IndMoveOptions = find(Distances(:,:,chosen)<=1);

    % When a player is on the boundary, five move options will not be
    % generated because the search would leave the grid. We insert the
    % appropriate number of options as 0 for the missing entries.
    if ListOfPositions(chosen, 1) == 1 
        IndMoveOptions = [IndMoveOptions(1); 0; IndMoveOptions(2:4)];
    end

    if ListOfPositions(chosen, 2) == 1 
        IndMoveOptions = [0; IndMoveOptions(1:4)];
    end

    if ListOfPositions(chosen, 1) == 21 
        IndMoveOptions = [IndMoveOptions(1:3); 0; IndMoveOptions(4)];
    end

    if ListOfPositions(chosen, 2) == 21 
        IndMoveOptions = [IndMoveOptions(1:4); 0];
    end

    % MoveOptions is set to have 5 entries; we set entries that are not
    % feasible because of the bounds of the grid or the location of
    % another player to 0, and these options are not selectable in the
    % GUI
    MoveOptions = zeros(5,2);
    for kk=1:length(IndMoveOptions)
       [MoveOptions(kk,1),MoveOptions(kk,2)]=ind2sub([handles.settings.Height,handles.settings.Width],IndMoveOptions(kk));
    end

    % Check for potential collisions with other players
    for ii=1:5
       for jj=1:handles.settings.N+handles.settings.Ncomputers
        if jj == chosen
            continue
        elseif MoveOptions(ii,1) == ListOfPositions(jj,1) && MoveOptions(ii,2) == ListOfPositions(jj,2)
            MoveOptions(ii,1) = 0;
            MoveOptions(ii,2) = 0;           
        end
       end
    end       
         
    % TERRITORIES MAP    
    % Take territories and convert it to a matrix with zeros for all
    % shared territories
    CleanTerritories = Territories;

    for ii=1:handles.settings.Height
        for jj=1:handles.settings.Width
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
    CleanTerritories(ListOfPositions(1,1), ListOfPositions(1,2)) = 14;
    CleanTerritories(ListOfPositions(2,1), ListOfPositions(2,2)) = 15;
    CleanTerritories(ListOfPositions(3,1), ListOfPositions(3,2)) = 16;
    CleanTerritories(ListOfPositions(4,1), ListOfPositions(4,2)) = 17;
    CleanTerritories(ListOfPositions(5,1), ListOfPositions(5,2)) = 18;
    
    % Assign the potential move options a number that will correspond to a
    % different shade of each player's color
    for ii=1:5
        if MoveOptions(ii,1) ~= 0
            if ii == 3
                continue
            end
            CleanTerritories(MoveOptions(ii,1), MoveOptions(ii,2)) = 19;
        end
    end
    
    % Assign a color for the move options to be highlighted in (dependent
    % on the color)
    % Could rewrite with flag to leave for loop
    if chosen == 1
        moveoptionscolor = green_m;
    end
    if chosen == 2
        moveoptionscolor = orange_m;
    end
    if chosen == 3
        moveoptionscolor = purple_m;
    end
    if chosen == 4
        moveoptionscolor = blue_m;
    end
    if chosen == 5
        moveoptionscolor = red_m;
    end
    
    % Create the image file of the current state
    FunCreateFigure(ListOfPositions, CleanTerritories, moveoptionscolor, MoveOptions)
    handles.axes1.Visible = 'on';
    axes(handles.axes1)
%     set(handles.axes1,'Unit','normalized','Position',[.1 0 1 .99])
    imshow('screen.png');

end

function [MoveOptions] = GetMoveOptions(chosen, ListOfPositions)

    handles = guidata(gcbo);
    
    Distances = zeros(handles.settings.Height,handles.settings.Width);
    % Create distances of current state       
    for nn=1:handles.settings.N+handles.settings.Ncomputers
        Distances(:,:,nn) = FunDistances(handles.settings.Size,nn,ListOfPositions,handles.settings.Metric);   
    end
    
    % Create territories of current state   
    Territories = cell(handles.settings.Height,handles.settings.Width);
    
    for ii=1:handles.settings.Height
        for jj=1:handles.settings.Width
            I=find(Distances(ii,jj,:)==min(Distances(ii,jj,:)));
            Territories(ii,jj)={I};
        end
    end

    % Create list of places to move to (including origin)
    IndMoveOptions = find(Distances(:,:,chosen)<=1);

    % When a player is on the boundary, five move options will not be
    % generated because the search would leave the grid. We insert the
    % appropriate number of options as 0 for the missing entries.
    if ListOfPositions(chosen, 1) == 1 
        IndMoveOptions = [IndMoveOptions(1); 0; IndMoveOptions(2:4)];
    end

    if ListOfPositions(chosen, 2) == 1 
        IndMoveOptions = [0; IndMoveOptions(1:4)];
    end

    if ListOfPositions(chosen, 1) == 21 
        IndMoveOptions = [IndMoveOptions(1:3); 0; IndMoveOptions(4)];
    end

    if ListOfPositions(chosen, 2) == 21 
        IndMoveOptions = [IndMoveOptions(1:4); 0];
    end

    % MoveOptions is set to have 5 entries; we set entries that are not
    % feasible because of the bounds of the grid or the location of
    % another player to 0, and these options are not selectable in the
    % GUI
    MoveOptions = zeros(5,2);
    for kk=1:length(IndMoveOptions)
       [MoveOptions(kk,1),MoveOptions(kk,2)]=ind2sub([handles.settings.Height,handles.settings.Width],IndMoveOptions(kk));
    end

    % Check for potential collisions with other players
    for ii=1:5
       for jj=1:handles.settings.N+handles.settings.Ncomputers
        if jj == chosen
            continue
        elseif MoveOptions(ii,1) == ListOfPositions(jj,1) && MoveOptions(ii,2) == ListOfPositions(jj,2)
            MoveOptions(ii,1) = 0;
            MoveOptions(ii,2) = 0;           
        end
       end
    end
    
end

function [ListOfPositions] = MakeListOfPositions   
    
    handles = guidata(gcbo);
    ListOfPositions = zeros(handles.settings.N+handles.settings.Ncomputers, 2);
    
    player1x = handles.loc11.String;
    player2x = handles.loc21.String;
    player3x = handles.loc31.String;
    player4x = handles.loc41.String;
    player5x = handles.loc51.String;
    player1y = handles.loc12.String;
    player2y = handles.loc22.String;
    player3y = handles.loc32.String;
    player4y = handles.loc42.String;
    player5y = handles.loc52.String;
    
    player1x = str2double(player1x);
    player2x = str2double(player2x);
    player3x = str2double(player3x);
    player4x = str2double(player4x);
    player5x = str2double(player5x);
    
    player1y = find(handles.settings.Alphabet == player1y);
    player2y = find(handles.settings.Alphabet == player2y);
    player3y = find(handles.settings.Alphabet == player3y);
    player4y = find(handles.settings.Alphabet == player4y);
    player5y = find(handles.settings.Alphabet == player5y);
    
    ListOfPositions = zeros(handles.settings.N+handles.settings.Ncomputers, 2);
    ListOfPositions(1,1) = player1x;
    ListOfPositions(2,1) = player2x;
    ListOfPositions(3,1) = player3x;
    ListOfPositions(4,1) = player4x;
    ListOfPositions(5,1) = player5x;
    ListOfPositions(1,2) = player1y;
    ListOfPositions(2,2) = player2y;
    ListOfPositions(3,2) = player3y;
    ListOfPositions(4,2) = player4y;
    ListOfPositions(5,2) = player5y;
    
    ListOfPositions(6,:) = handles.settings.Computers(1,:);
    ListOfPositions(7,:) = handles.settings.Computers(2,:);
    ListOfPositions(8,:) = handles.settings.Computers(3,:);
    ListOfPositions(9,:) = handles.settings.Computers(4,:);
    ListOfPositions(10,:) = handles.settings.Computers(5,:);
    ListOfPositions(11,:) = handles.settings.Computers(6,:);
    ListOfPositions(12,:) = handles.settings.Computers(7,:);
    ListOfPositions(13,:) = handles.settings.Computers(8,:);

    
end