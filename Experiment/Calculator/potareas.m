function potareas

   playerlocationscell = {'Locations'};
   
   % Add the UI components
   hs = addcomponents;
   
   % Make figure visible after adding components
   hs.fig.Visible = 'on';
    
      
   function hs = addcomponents
       
       % add components, save handles in a struct
        hs.fig = figure( 'units','normalized', 'OuterPosition', [0 0 1 1], ...
            'Name', 'Calculator','NumberTitle','off', 'MenuBar', 'none');
        hbox = uiextras.HBox( 'Parent', hs.fig, 'Padding', 20);
        vbox1 = uiextras.VBox( 'Parent', hbox);
        hs.playerlocations = uicontrol('Parent',vbox1,'Style','text',...
                'String',playerlocationscell, 'FontWeight', 'bold', 'FontSize', 32.0, 'Units', 'normalized', 'ForegroundColor', 'b');
        hbox11 = uiextras.HBox( 'Parent', vbox1);
        hs.player1 = uicontrol('Parent',hbox11,'Style','text',...
                'String','1:', 'FontSize', 20,'Tag','player1', 'ForegroundColor', 'b');
        hs.loc12 = uicontrol('Parent', hbox11,'Style','edit',...
                'String','F', 'FontSize', 20,'Tag','loc12'); 
        hs.loc11 = uicontrol('Parent', hbox11,'Style','edit',...
                'String','5', 'FontSize', 20,'Tag','loc11');    
        hbox21 = uiextras.HBox( 'Parent', vbox1);
        hs.player2 = uicontrol('Parent',hbox21,'Style','text',...
                'String','2:', 'FontSize', 20,'Tag','player2', 'ForegroundColor', 'b');
        hs.loc22 = uicontrol('Parent', hbox21,'Style','edit',...
                'String','R', 'FontSize', 20,'Tag','loc22');   
        hs.loc21 = uicontrol('Parent', hbox21,'Style','edit',...
                'String','3', 'FontSize', 20,'Tag','loc21');   
        hbox31 = uiextras.HBox( 'Parent', vbox1);    
        hs.player3 = uicontrol('Parent',hbox31,'Style','text',...
                'String','3:', 'FontSize', 20,'Tag','player3', 'ForegroundColor', 'b');
        hs.loc32 = uicontrol('Parent', hbox31,'Style','edit',...
                'String','O', 'FontSize', 20,'Tag','loc32');
        hs.loc31 = uicontrol('Parent', hbox31,'Style','edit',...
                'String','14', 'FontSize', 20,'Tag','loc31');  
        hbox41 = uiextras.HBox( 'Parent', vbox1);
        hs.player4 = uicontrol('Parent',hbox41,'Style','text',...
                'String','4:', 'FontSize', 20,'Tag','player4', 'ForegroundColor', 'b');  
        hs.loc42 = uicontrol('Parent', hbox41,'Style','edit',...
                'String','J', 'FontSize', 20,'Tag','loc42');
        hs.loc41 = uicontrol('Parent', hbox41,'Style','edit',...
                'String','17', 'FontSize', 20,'Tag','loc41');  
        hbox51 = uiextras.HBox( 'Parent', vbox1);
        hs.player5 = uicontrol('Parent',hbox51,'Style','text',...
                'String','5:', 'FontSize', 20,'Tag','player5', 'ForegroundColor', 'b');
        hs.loc52 = uicontrol('Parent', hbox51,'Style','edit',...
                'String','D', 'FontSize', 20,'Tag','loc52');                                         
        hs.loc51 = uicontrol('Parent', hbox51,'Style','edit',...
                'String','16', 'FontSize', 20,'Tag','loc51'); 
            
        hbox2 = uiextras.HBox( 'Parent', vbox1, 'Padding', 5);    
        hs.calculateit = uicontrol( 'Parent', hbox2, ...
             'String', 'Calculate', 'FontSize', 20.0, 'Tag','calculateit', 'Callback',@calculateit_Callback);
        hs.areatext = uicontrol('Parent',vbox1,'Style','text',...
                'String','Areas', 'FontWeight', 'bold', 'FontSize', 32.0, 'Tag', 'areatext', 'ForegroundColor', 'b'); 
        hboxplayerstats = uiextras.HBox( 'Parent', vbox1, 'Padding', 5);
        vboxplayernums = uiextras.VBox( 'Parent', hboxplayerstats );  
        hs.player12 = uicontrol('Parent',vboxplayernums,'Style','text',...
                'String','1:', 'FontSize', 20,'Tag','player12', 'ForegroundColor', 'b');
        hs.player22 = uicontrol('Parent',vboxplayernums,'Style','text',...
                'String','2:', 'FontSize', 20,'Tag','player22', 'ForegroundColor', 'b');
        hs.player32 = uicontrol('Parent',vboxplayernums,'Style','text',...
                'String','3:', 'FontSize', 20,'Tag','player32', 'ForegroundColor', 'b');
        hs.player42 = uicontrol('Parent',vboxplayernums,'Style','text',...
                'String','4:', 'FontSize', 20,'Tag','player42', 'ForegroundColor', 'b');   
        hs.player52 = uicontrol('Parent',vboxplayernums,'Style','text',...
                'String','5:', 'FontSize', 20,'Tag','player52', 'ForegroundColor', 'b');
        vboxplayerareas = uiextras.VBox( 'Parent', hboxplayerstats );
        hs.area1 = uicontrol('Parent',vboxplayerareas,'Style','text',...
                'String','0', 'FontSize', 20,'Tag','area1');
        hs.area2 = uicontrol('Parent',vboxplayerareas,'Style','text',...
                'String','0', 'FontSize', 20,'Tag','area2');
        hs.area3 = uicontrol('Parent',vboxplayerareas,'Style','text',...
                'String','0', 'FontSize', 20,'Tag','area3');
        hs.area4 = uicontrol('Parent',vboxplayerareas,'Style','text',...
                'String','0', 'FontSize', 20,'Tag','area4');
        hs.area5 = uicontrol('Parent',vboxplayerareas,'Style','text',...
                'String','0', 'FontSize', 20,'Tag','area5');  
        hs.axes1 = axes( 'Parent', hbox, ...
            'ActivePositionProperty', 'OuterPosition');      
               
        hbox.Sizes = [210 -1];
        vbox1.Sizes = [80 -3 -3 -3 -3 -3 -3 80 -7];
        
        % Check if 'enter' is pressed when focus on button and exec callback
        set(hs.calculateit,'KeyPressFcn',{@pb_kpf ,hs});
        % Check if 'enter' is pressed when focus on figure and exec callback
        set(hs.fig,'KeyPressFcn',{@pb_kpf ,hs});
                

        set(hs.axes1,'visible','off');

        global playerNumber

        if playerNumber == 1
            set(hs.player1, 'ForeGroundColor', 'r')
            set(hs.player12, 'ForeGroundColor', 'r')
        end

        if playerNumber == 2
            set(hs.player2, 'ForeGroundColor', 'r')
            set(hs.player22, 'ForeGroundColor', 'r')
        end

        if playerNumber == 3
            set(hs.player3, 'ForeGroundColor', 'r')
            set(hs.player32, 'ForeGroundColor', 'r')
        end

        if playerNumber == 4
            set(hs.player4, 'ForeGroundColor', 'r')
            set(hs.player42, 'ForeGroundColor', 'r')
        end

        if playerNumber == 5
            set(hs.player5, 'ForeGroundColor', 'r')
            set(hs.player52, 'ForeGroundColor', 'r')
        end               
    
        guidata(hs.fig,hs) ;
                                      
   end
        
end

    function calculateit_Callback(hObject, event)
    
    handles = guidata(gcbo);

        handles.calculateit.Enable = 'off';
        handles.calculateit.String = 'Recalculating';
            
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
        

        failed = FunCheckInput(player1x, player1y, player2x, player2y, player3x, player3y, player4x, player4y, player5x, player5y);

        if failed
            handles.calculateit.Enable = 'on';
            handles.calculateit.String = 'Calculate';
            return
        end

        [Areas, ListOfPositionsCurrent, failed] = FunCalculatorIt(player1x, player1y, player2x, player2y, player3x, player3y, player4x, player4y, player5x, player5y);

        if failed
            handles.calculateit.Enable = 'on';
            handles.calculateit.String = 'Calculate';
            return
        end

    %     set(handles.startup,'visible','off')

        global playerNumber;
        global sessionNumber;

        Areas = round(Areas, 2);

        handles.area1.String = Areas(1,1);
        handles.area2.String = Areas(1,2);
        handles.area3.String = Areas(1,3);
        handles.area4.String = Areas(1,4);
        handles.area5.String = Areas(1,5);

        handles.axes1.Visible = 'on';
        axes(handles.axes1)
        set(handles.axes1,'Unit','normalized','Position',[.1 0 1 .99])
%         set(0,'defaultaxesposition',[0 0 1 1])
%         axis square

        imshow('screen.png');
        
%         imshow('screen.png', 'Border', 'loose')
        
%         axis image        
        
%         axis normal         
        
%         truesize(handles.axes1)
        
%         maximize(gcf)
        
        
%         Pix_SS = get(0,'screensize');
%         truesize(handles.fig,[Pix_SS(3) Pix_SS(4)]) 

        calctime = clock;

        save(strcat('./Data/',num2str(sessionNumber),'_',num2str(playerNumber),'_',mat2str(calctime),'.mat'),'ListOfPositionsCurrent','calctime')

        handles.calculateit.Enable = 'on';
        handles.calculateit.String = 'Calculate';
    
    end
    
function pb_kpf(varargin)
    if varargin{1,2}.Character == 13
        calculateit_Callback
    end
end