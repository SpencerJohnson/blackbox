

PACKAGE BODY Actions2 IS
	
	 Procedure Move (Selection : IN Option;GameBoard : IN OUT BoardType) is
	 			CarrotMoveRecord : MoveElement;
	 Begin --Move

			If Selection = Left then
				--Top
				If GameBoard.CarrotPosition.Side = Top and Gameboard.CarrotPosition.Index = 1 then
					GameBoard.CarrotPosition.Side := (Left);
					Gameboard.CarrotPosition.Index := 1;
				elsif Gameboard.CarrotPosition.Side = (Top) and Gameboard.CarrotPosition.Index /= 1 then
					GameBoard.CarrotPosition.Side := (Top);
					Gameboard.CarrotPosition.Index := Gameboard.CarrotPosition.Index -1;
				--Left Side	
				elsIf Gameboard.CarrotPosition.Side = (Left) and Gameboard.CarrotPosition.Index = Gameboard.Length  then
					GameBoard.CarrotPosition.Side := (Bottom);
					Gameboard.CarrotPosition.Index := 1;
				elsIf Gameboard.CarrotPosition.Side = (Left) and Gameboard.CarrotPosition.Index /= Gameboard.Length  then
					GameBoard.CarrotPosition.Side := (Left);
					Gameboard.CarrotPosition.Index := Gameboard.CarrotPosition.Index +1;	
				--Bottom Side
				elsIf Gameboard.CarrotPosition.Side = (Bottom) and Gameboard.CarrotPosition.Index = Gameboard.Length  then
					GameBoard.CarrotPosition.Side := (Right);
					Gameboard.CarrotPosition.Index := 10;
				elsIf Gameboard.CarrotPosition.Side = (Bottom) and Gameboard.CarrotPosition.Index /= Gameboard.Length  then
					GameBoard.CarrotPosition.Side := (Bottom);
					Gameboard.CarrotPosition.Index := Gameboard.CarrotPosition.Index +1;	
				--Right Side
				elsIf Gameboard.CarrotPosition.Side = (Right) and Gameboard.CarrotPosition.Index = 1  then
					GameBoard.CarrotPosition.Side := (Top);
					Gameboard.CarrotPosition.Index := 10;
				elsIf Gameboard.CarrotPosition.Side = (Right) and Gameboard.CarrotPosition.Index /= 1  then
					GameBoard.CarrotPosition.Side := (Right);
					Gameboard.CarrotPosition.Index := Gameboard.CarrotPosition.Index -1;	
				end if;
			elsif Selection = (Right) then
				--Top
				If Gameboard.CarrotPosition.Side = (Top) and Gameboard.CarrotPosition.Index = Gameboard.Length then
					GameBoard.CarrotPosition.Side := (Right);
					Gameboard.CarrotPosition.Index := 1;
				elsif Gameboard.CarrotPosition.Side = (Top) and Gameboard.CarrotPosition.Index /= Gameboard.Length then
					GameBoard.CarrotPosition.Side := (Top);
					Gameboard.CarrotPosition.Index := Gameboard.CarrotPosition.Index +1;
				--Left Side	
				elsIf Gameboard.CarrotPosition.Side = (Left) and Gameboard.CarrotPosition.Index = 1  then
					GameBoard.CarrotPosition.Side := (Top);
					Gameboard.CarrotPosition.Index := 1;
				elsIf Gameboard.CarrotPosition.Side = (Left) and Gameboard.CarrotPosition.Index /= 1  then
					GameBoard.CarrotPosition.Side := (Left);
					Gameboard.CarrotPosition.Index := Gameboard.CarrotPosition.Index -1;	
				--Bottom Side
				elsIf Gameboard.CarrotPosition.Side = (Bottom) and Gameboard.CarrotPosition.Index = 1  then
					GameBoard.CarrotPosition.Side := (Left);
					Gameboard.CarrotPosition.Index := 1;
				elsIf Gameboard.CarrotPosition.Side = (Bottom) and Gameboard.CarrotPosition.Index /= 1  then
					GameBoard.CarrotPosition.Side := (Bottom);
					Gameboard.CarrotPosition.Index := Gameboard.CarrotPosition.Index -1;	
				--Right Side
				elsIf Gameboard.CarrotPosition.Side = (Right) and Gameboard.CarrotPosition.Index = Gameboard.Length  then
					GameBoard.CarrotPosition.Side := (Bottom);
					Gameboard.CarrotPosition.Index := 1;
				elsIf Gameboard.CarrotPosition.Side = (Right) and Gameboard.CarrotPosition.Index /= Gameboard.Length  then
					GameBoard.CarrotPosition.Side := (Right);
					Gameboard.CarrotPosition.Index := Gameboard.CarrotPosition.Index +1;	
				end if;
			end if;
			CarrotMoveRecord.MoveType := (Move);
			CarrotMoveRecord.CarrotPosition := (Right,Gameboard.CarrotPosition.Index);
			Push(GameBoard.Moves, CarrotMoveRecord);
	 End Move;
	 
	 Procedure FireLazer (GameBoard : IN OUT BoardType) is
	 
		Type LaserInfo is Record
			
			HitMirror : Boolean := False; --Made false again after it changes direction
			LazerMovement : BoxPosition;
			HitMirrorLetter : Character;
			HitMirrorIndex : Integer;
			ShotFired : Boolean := False;
			ShotFinished : Boolean := False;
			GoingDown : Boolean := False;
			GoingUp : Boolean := False;
			GoingLeft : Boolean := False;
			GoingRight : Boolean := False;
			OutsideTop : Boolean := False;
			OutsideBottom : Boolean := False;
			OutsideLeft : Boolean := False;
			OutsideRight : Boolean := False;
			MoveRecord : MoveElement;
		end Record;
		Laser : LaserInfo;
		Procedure InitialLaserDirection (Laser : in out LaserInfo; Gameboard : in out BoardType) is
			
		
		begin --InitialLaserDirection
			--Check the Sides
			If Gameboard.CarrotPosition.Side = (Top)then
				GameBoard.LaserPosition.InPosition.Side := GameBoard.CarrotPosition.Side;
				GameBoard.LaserPosition.InPosition.Index := GameBoard.CarrotPosition.Index;
				Laser.GoingDown := True;
			elsif Gameboard.CarrotPosition.Side = (Left)then
				GameBoard.LaserPosition.InPosition.Side := GameBoard.CarrotPosition.Side;
				GameBoard.LaserPosition.InPosition.Index := GameBoard.CarrotPosition.Index;	
				Laser.GoingRight := True;		
			elsif Gameboard.CarrotPosition.Side = (Right)then
				GameBoard.LaserPosition.InPosition.Side := GameBoard.CarrotPosition.Side;
				GameBoard.LaserPosition.InPosition.Index := GameBoard.CarrotPosition.Index;			
				Laser.GoingLeft := True;
			elsif Gameboard.CarrotPosition.Side = (Bottom)then
				GameBoard.LaserPosition.InPosition.Side := GameBoard.CarrotPosition.Side;
				GameBoard.LaserPosition.InPosition.Index := GameBoard.CarrotPosition.Index;			
				Laser.GoingUp := True;
			end if;
			GameBoard.LaserPosition.OutPosition.Side := GameBoard.LaserPosition.InPosition.Side;
			GameBoard.LaserPosition.OutPosition.Index := GameBoard.LaserPosition.InPosition.Index;							
		end InitialLaserDirection;
		 
		Procedure ChangeLaserDirection (Laser : in out LaserInfo; Gameboard : In out BoardType) is
			Begin --ChangeLaserDirection
				If Laser.HitMirror = true then
					--LaserPosition.InPosition.Side
					--LaserPosition.InPosition.Index
					--laserPosition.OutPosition.Side
					--Laser.Position.InPositiion.Index
					If GameBoard.Box(Laser.HitMirrorLetter,Laser.HitMirrorIndex).Angle= true then
						if Laser.GoingDown = true then
							Laser.GoingDown := false;
							Laser.GoingLeft := true;
						elsif Laser.GoingUp = true then
							Laser.GoingUp := false;
							Laser.GoingRight := True;
						elsif Laser.GoingRight = True then
							Laser.GoingRight := False;
							Laser.GoingUp := True;
						elsif Laser.GoingLeft = True then
							Laser.GoingLeft := False;
							Laser.GoingDown := true;
						end if;
					elsif GameBoard.Box(Laser.HitMirrorLetter,Laser.HitMirrorIndex).Angle= False then
						if Laser.GoingDown = true then
							Laser.GoingDown := false;
							Laser.GoingRight := true;
						elsif Laser.GoingUp = true then
							Laser.GoingUp := false;
							Laser.GoingLeft := True;
						elsif Laser.GoingRight = True then
							Laser.GoingRight := False;
							Laser.GoingDown := True;
						elsif Laser.GoingLeft = True then
							Laser.GoingLeft := False;
							Laser.GoingUp := true;
						end if;								
					end if;
				end if;
		end ChangeLaserDirection;		
		
		
		Procedure MoveLaser (Laser : in out LaserInfo; GameBoard : in out BoardType) is 
		
		Begin --MoveLaser
			--This part be wrong.
			if Laser.ShotFinished = False then
			
				If Laser.GoingUp = true and then Laser.LazerMovement.Y-1 /= GameBoard.Length +1 then
					Laser.LazerMovement.Y := Laser.LazerMovement.Y -1;
				else
					Laser.ShotFinished := True;					
					Laser.OutsideTop := True;
				end if;
				
				if Laser.GoingDown = True and then Laser.LazerMovement.Y-1 /= GameBoard.Length +1 then
					Laser.LazerMovement.Y := Laser.LazerMovement.Y +1;
				else
					Laser.ShotFinished := True;				
					Laser.OutsideBottom:= True;
				end if;
				if Laser.GoingRight = True and then ((Character'Pos(Laser.LazerMovement.X) -64)  +1) > GameBoard.Length then
					Laser.LazerMovement.X := Character'Pred(Laser.LazerMovement.X);
				else
					Laser.ShotFinished := True;				
					Laser.OutsideRight := True;
				end if;
				if Laser.GoingLeft = True and then Character'Pred(Laser.LazerMovement.X) <= 'A' then
					Laser.LazerMovement.X := Character'Pred(Laser.LazerMovement.X);
				else
					Laser.ShotFinished := True;
					Laser.OutsideLeft := True;
				end if;
				
				
				If GameBoard.Box(Laser.LazerMovement.X,Laser.LazerMovement.Y).Mirror = True then
					Laser.HitMirrorLetter := Laser.LazerMovement.X;
					Laser.HitMirrorIndex := Laser.LazerMovement.Y;
					ChangeLaserDirection(Laser, GameBoard);
				end if;
					
					
			else
				--This part be wrong.

				If Laser.OutsideLeft = True then
					GameBoard.LaserPosition.OutPosition := (Left,Laser.LazerMovement.Y);
				elsif Laser.OutsideRight = True then
					GameBoard.LaserPosition.OutPosition := (Right,Laser.LazerMovement.Y);
				elsif Laser.OutsideTop = True then
					GameBoard.LaserPosition.OutPosition := (Top,Laser.LazerMovement.Y);
				elsif Laser.OutsideBottom = True then
					GameBoard.LaserPosition.OutPosition := (Bottom,Laser.LazerMovement.Y);
				end if;
				Laser.OutsideTop := False;
				Laser.OutsideBottom := False;
				Laser.OutsideRight := False;
				Laser.OutsideLeft := False;
				Laser.MoveRecord.MoveType := (Shot);
				Laser.MoveRecord.LaserPosition.InPosition := (Right,Gameboard.CarrotPosition.Index);
				Laser.MoveRecord.LaserPosition.OutPosition := (Right,Gameboard.CarrotPosition.Index);
				Push(GameBoard.Moves, Laser.MoveRecord);
			end if;
			
		End MoveLaser;			
		
	Begin --FireLaser
		If GameBoard.Shots /= 0 then
			GameBoard.Shots := GameBoard.Shots -1;
			InitialLaserDirection(Laser, GameBoard);	
			Laser.ShotFired	:= True;
			Laser.ShotFinished := False;
			Loop
			Exit when Laser.ShotFinished = true;
				MoveLaser(Laser,GameBoard);
			end loop;
			Laser.ShotFinished := False;
		else
			GameBoard.End_Of_Game := True;
		end if;
	End FireLazer;

END Actions2;