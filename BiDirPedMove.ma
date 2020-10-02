[top]
components : PedestrianMovement

[PedestrianMovement]
type : cell
width : 30
height : 30
delay : transport
defaultDelayTime : 400
border : wrapped
neighbors : 						 PedestrianMovement(2,-1) PedestrianMovement(2,0) PedestrianMovement(2,1)
neighbors : 						 PedestrianMovement(1,-1) PedestrianMovement(1,0) PedestrianMovement(1,1)
neighbors : PedestrianMovement(0,-2) PedestrianMovement(0,-1) PedestrianMovement(0,0) PedestrianMovement(0,1) PedestrianMovement(0,2)
neighbors : 						 PedestrianMovement(-1,-1) PedestrianMovement(-1,0) PedestrianMovement(-1,1)
neighbors : 						 PedestrianMovement(-2,-1) PedestrianMovement(-2,0) PedestrianMovement(-2,1)
%%%% state values %%%%
% 0 - cell unoccupied
% 1 - cell occupied with an up walker
% 2 - cell occupied with a down walker
% 3 - cell occupied with an obstacle
initialvalue : 0
initialrowvalue :  0     000000000000000000000020000000
initialrowvalue :  1     000003000000001000000000000100
initialrowvalue :  2     000001000000000000003330000000
initialrowvalue :  3     020000000030000002000000000000
initialrowvalue :  4     000000000330000000000100000200
initialrowvalue :  5     000000000300000000000000000300
initialrowvalue :  6     000200000020000300000000030000
initialrowvalue :  7     000000000000000200031000000000
initialrowvalue :  8     003000000000000000000000000000
initialrowvalue :  9     000000020000030000000000000000
initialrowvalue :  10    000000010000330000000000000300
initialrowvalue :  11    000000030000020000000000000000
initialrowvalue :  12    000030000000000000000000100000
initialrowvalue :  13    001000000200000010000000000002
initialrowvalue :  14    000000000003000000003000000001
initialrowvalue :  15    000000000000000100000000002000
initialrowvalue :  16    330000003000000200000000300000
initialrowvalue :  17    000000000010000003000000000033
initialrowvalue :  18    000000000000000000000000000000
initialrowvalue :  19    000200000000000000000001000000
initialrowvalue :  20    000330001000000030000020000000
initialrowvalue :  21    000300000000000000000000000000
initialrowvalue :  22    000000000000002000000000000000
initialrowvalue :  23    000000300000000000000003000001
initialrowvalue :  24    000002000000000000000033000000
initialrowvalue :  25    000000000000003000300000000000
initialrowvalue :  26    000003000000003000002000003000
initialrowvalue :  27    000001000000003000000010000000
initialrowvalue :  28    000000000000000000100000000000
initialrowvalue :  29    000000000000000000000000100000
% Testing Setup
%initialrowvalue : 0 00000000
%initialrowvalue : 1 00032200
%initialrowvalue : 2 00000000
%initialrowvalue : 3 00001000
%initialrowvalue : 4 00200000
%initialrowvalue : 5 03130000
%initialrowvalue : 6 00000000
%initialrowvalue : 7 00000000
localtransition : PedestrianBehaviour

[PedestrianBehaviour]
%%%% Rule 1 %%%%
% Move forward - up walkers
rule : 0 100 {(0,0)=1 and (-1,0)=0 and (-2,0)!=2}	 %the cell ahead is available and
rule : 1 100 {(0,0)=0 and (-1,0)!=2 and (1,0)=1}	 %the next cell is not a down walker
% Move forward - down walkers
rule : 0 100 {(0,0)=2 and (1,0)=0 and (2,0)!=1}
rule : 2 100 {(0,0)=0 and (1,0)!=1 and (-1,0)=2}
				
%%%% Rule 2 %%%%
% There is a walker/obstacle ahead, move right if another walker isn`t going to walk there
% up walker
rule : 0 100 {(0,0)=1 and (-1,0)!=0		% walker or obstacle is next cell ahead
				and (0,1)=0				% and the right side is available
				and (-1,1)!=2			% ensure down walker is not going for your cell
				and (1,1)!=1}			% ensure up walker is not going for your cell
rule : 1 100 {(0,0)=0 and (0,-1)=1		% move the up walker to the right
				and (-1,-1)!=0			% there is an obstacle or walker in cell (-1,-1)
				and (-1,0)!=2			% ensure down walker is not going for that cell
				and (1,0)!=1}			% ensure up walker is not going for that cell
% down walker
rule : 0 100 {(0,0)=2 and (1,0)!=0		% walker or obstacle is next cell ahead
				and (0,-1)=0			% and the right side is available
				and (1,-1)!=1			% ensure up walker is not going for your cell
				and (-1,-1)!=2}			% ensure down walker is not going for your cell
				
rule : 2 100 {(0,0)=0 and (0,1)=2		% move the down walker to the right
				and (1,1)!=0			% there is an obstacle or walker in cell (1,1)
				and (1,0)!=1			% ensure up walker is not going for that cell
				and (-1,0)!=2}			% ensure down walker is not going for your cell
%%%% Rule 3 %%%%
% Walker/obstacle ahead and to the right, move to the left if another walker isn`t going to walk there
% up walker
rule : 0 100 {(0,0)=1 and (-1,0)!=0		% walker or obstacle is next cell ahead
				and (0,1)!=0			% walker or obstacle is also to the right
				and (0,-1)=0			% the left side is available
				and (-1,-1)!=2			% ensure down walker is not going for left cell
				and (1,-1)!=1}			% ensure up walker is not going for left cell
rule : 1 100 {(0,0)=0 and (0,1)=1		% move the up walker to the left
				and (-1,1)!=0			% there is an obstacle or walker in cell (-1,1)
				and (0,2)!=0			% there is an obstacle or walker in cell (0,2) also
				and (-1,0)!=2			% ensure down walker is not going for that cell
				and (1,0)!=1}			% ensure up walker is not going for that cell
% down walker
rule : 0 100 {(0,0)=2 and (1,0)!=0		% walker or obstacle is next cell ahead
				and (0,-1)!=0			% and the right side is an obstacle or walker
				and (0,1)=0				% the left side is available
				and (1,1)!=1			% ensure up walker is not going for left cell
				and (-1,1)!=2}			% ensure down walker is not going for left cell
				
rule : 2 100 {(0,0)=0 and (0,-1)=2		% move the down walker to the right
				and (1,-1)!=0			% there is an obstacle or walker in cell (1,-1)
				and (0,-2)!=0			% there is an obstacle or walker in cell (0,-2) also
				and (1,0)!=1			% ensure up walker is not going for that cell
				and (-1,0)!=2}			% ensure down walker is not going for your cell
%%%% Rule 4 %%%%
% Avoid collision, move right if an up and down walker are vying for the same cell and it's possible
% up walker
rule : 0 100 {(0,0)=1 and (1,0)=0 		% cell ahead is empty
				and (-2,0)=2 			% 2 cells ahead is down walker
				and (0,1)=0				% right cell is available
				and (-1,1)!=2			% ensure down walker is not going for right cell
				and (1,1)!=1}			% ensure up walker is not going for right cell
rule : 1 100 {(0,0)=0 and (0,-1)=1
				and (-2,-1)=2			% cell (-2,-1) is a down walker
				and (-1,-1)=0			% cell (-1,-1) is empty
				and (-1,0)!=2			% ensure down walker is not going for right cell
				and (1,0)!=1}			% ensure up walker is not going for right cell
% down walker
rule : 0 100 {(0,0)=2 and (1,0)=0		% cell ahead is empty
				and (2,0)=1				% 2 cells ahead is up walker
				and (0,-1)=0			% right cell is available
				and (1,-1)!=1			% ensure up walker is not going for right cell
				and (-1,-1)!=2}			% ensure down walker is not going for right cell
rule : 2 100 {(0,0)=0 and (0,1)=2
				and (2,1)=1				% cell (2,1) is an up walker
				and (1,1)=0				% cell (1,1) is empty
				and (1,0)!=1			% ensure up walker is not going for right cell
				and (-1,0)!=2}			% ensure down walker is not going for right cell

%%%% Rule 5 %%%%
% Default - don't move
rule : {(0,0)} 100 {t}