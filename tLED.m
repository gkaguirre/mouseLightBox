%The ARRAY variables:

 %* <Sessiontime(0),TimeOneB1P1(1),TimeTwoB1P1(2),intensityTimeONER(3),intensityTimeTWOR(4),intensityTimeONEB(5),intensityTimeTWOB(6),intensityTimeONEU(7),intensityTimeTWOU(8),
 %*                 TimeOneB1P2(9),TimeTwoB1P2(10),intensityTimeONER(11),intensityTimeTWOR(12),intensityTimeONEB(13),intensityTimeTWOB(14),intensityTimeONEU(15),intensityTimeTWOU(16),
 %*                 TimeOneB2P1(17),TimeTwoB2P1(18),intensityTimeONER(19),intensityTimeTWOR(20),intensityTimeONEB(21),intensityTimeTWOB(22),intensityTimeONEU(23),intensityTimeTWOU(24),
 %*                 TimeOneB2P2(25),TimeTwoB2P2(26),intensityTimeONER(27),intensityTimeTWOR(28),intensityTimeONEB(29),intensityTimeTWOB(30),intensityTimeONEU(31),intensityTimeTWOU(32),
 %*                 TimeOneB3P1(33),TimeTwoB3P1(34),intensityTimeONER(35),intensityTimeTWOR(36),intensityTimeONEB(37),intensityTimeTWOB(38),intensityTimeONEU(39),intensityTimeTWOU(40),
 %*                 TimeOneB3P2(41),TimeTwoB3P2(42),intensityTimeONER(43),intensityTimeTWOR(44),intensityTimeONEB(45),intensityTimeTWOB(46),intensityTimeONEU(47),intensityTimeTWOU(48),
 %*                 TimeOneB4P1(49),TimeTwoB4P1(50),intensityTimeONER(51),intensityTimeTWOR(52),intensityTimeONEB(53),intensityTimeTWOB(54),intensityTimeONEU(55),intensityTimeTWOU(56),
 %*                 TimeOneB4P2(57),TimeTwoB4P2(58),intensityTimeONER(59),intensityTimeTWOR(60),intensityTimeONEB(61),intensityTimeTWOB(62),intensityTimeONEU(63),intensityTimeTWOU(64)>
 %*/
 
 % If one pannel is not going to be use you can put 0 to all the variables of that panel
 % The same with a entire box(chamber). You can put 0 to all 16 variable of that box
 checkport=false;
 %g=exist device;
 try
     readline(device);
 catch
     clear all;

 end
if (exist('device')==1)
 if(readline(device)=="A")
  e=true;
  f='H';
  writeline(device,f);
  
 else
     clear all;
     disp("Serial port not connected")
    checkport=true;
    e=false;
 end
 else
     clear all;
     disp("Serial port not exist")
    checkport=true;
    e=false;
end

pause(1);
go=true;
d=serialportlist("available");
i=0;
b=length(d);

  
  
 while (checkport==1) && (i<b)
  i=i+1;
  disp("Searching for Serial port")
  try
  device = serialport(d(1,i),115200);
  configureTerminator(device,"CR/LF");
  checkport=false;
  catch
  checkport=true;
  end
  if(checkport==false)
     %c='arduino';
     clear c;
     c=readline(device);
     %c=read(device,1,"char");
     
    if(class(c)~='double')     
     if(c == "A"  )
      disp('serial port found')
      f='H';
      writeline(device,f);
      e=true;
     else
         checkport=true;
         e==false;
     end
    else
        checkport=true;
        e=false;
    end
     
  end
 end
 
 if (e==false)
     disp('serial port NOT found')
     clear all;
 end
 
 
 
while go && e               
a= input('Enter Array: ','s');
writeline(device,a);

 while go
  clear a;
  a= input('Enter S to STOP the Session OR After Session COMPLETED to Reset the Unit: ','s');
  
   if (a == 'S')
    disp('Session STOP or Completed');
    go=false;
    clear a;
    clear device;
    pause(1);
    device = serialport;
    pause(1);
    %clear device;
   end
 end
end
