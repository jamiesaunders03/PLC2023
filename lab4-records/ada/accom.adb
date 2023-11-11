with Ada.Text_IO;
use Ada.Text_IO;
with Ada.Integer_Text_IO;
use Ada.Integer_Text_IO;
with Ada.Strings.Unbounded;
use Ada.Strings.Unbounded;

procedure Accom is

    type AccomVariant is (ACCKIND_HOUSE,ACCKIND_FLAT);
    type Accommodation (accom_variant : AccomVariant) is
        record
            street : Unbounded_String;
            house_number : Integer;
            case accom_variant is 
                when ACCKIND_HOUSE =>
                    floor_count : Integer;
                when ACCKIND_FLAT =>
                    floor : Integer;
            end case;
        end record;

    procedure Put_FloorTh(floor : Integer) is
    begin
        if floor = 0 then
            Put("ground");
        else
            Put(floor,0);
            case floor mod 10 is
                when 1 => Put("st");
                when 2 => Put("nd");
                when 3 => Put("rd");
                when others => Put("th");
            end case;
        end if;
    end Put_FloorTh;

    procedure Put_Accommodation(accom : Accommodation) is
    begin
        if accom.accom_variant = ACCKIND_HOUSE then
            Put(accom.floor_count, 0); -- 0 means: put no spaces before the number
            Put(" storey house at ");
            Put(accom.house_number, 0);
            Put(" ");
            Put(To_String(accom.street));
        else 
            Put_FloorTh(accom.floor);
            Put(" floor flat at ");
            Put(accom.house_number, 0);
            Put(" ");
            Put(To_String(accom.street));
        end if;
    end Put_Accommodation;

    myHouse : Accommodation
        := (accom_variant => ACCKIND_HOUSE,
            house_number => 111,
            street => To_Unbounded_String("Golden Avenue"),
            floor_count => 4);

   myFlat1 : Accommodation
       := (accom_variant => ACCKIND_FLAT, -- the discriminant
           house_number => 81,
           street => To_Unbounded_String("Silver Street"),
           floor => 0);

   myFlat2 : Accommodation
       := (accom_variant => ACCKIND_FLAT, -- the discriminant
           house_number => 81,
           street => To_Unbounded_String("Silver Street"),
           floor => 7);

begin
    Put_Accommodation(myHouse);
    Put_Line("");
    Put_Accommodation(myFlat1);
    Put_Line("");
    Put_Accommodation(myFlat2);
    Put_Line("");
end Accom;
