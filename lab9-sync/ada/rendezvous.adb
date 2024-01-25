-- Author: mik
with Ada.Text_IO;
use Ada.Text_IO;
with Ada.Integer_Text_IO;
use Ada.Integer_Text_IO;

procedure rendezvous is

    task A is
        entry Exchange(N : in Integer; R : out Integer; S : out Integer);
    end A;
    
    task body A is
        Sum : Integer := 0;
        Serial : Integer := 0;
    begin
        loop
            accept Exchange(N : in Integer; R : out Integer; S : out Integer) 
            do
                Sum := Sum + N;
                R := Sum;
                S := Serial;
                Serial := Serial + 1;
            end; -- the calling task in now released
            exit when Sum > 10;
        end loop;
        
        loop -- dummy loop, will never finish
            null;
        end loop;
    end A;
    
    I : Integer;
    S : Integer;
begin
    A.Exchange(1,I,S); -- I = 1
    Put("I = "); Put(I); Put_Line("");
    A.Exchange(1,I,S); -- I = 2
    Put("I = "); Put(I); Put_Line("");
    A.Exchange(9,I,S); -- A will enter the dummy loop
    Put("I = "); Put(I); Put_Line("");
    A.Exchange(1,I,S); -- rendezvous will never happen
    Put("I = "); Put(I); Put_Line("");
end rendezvous;
