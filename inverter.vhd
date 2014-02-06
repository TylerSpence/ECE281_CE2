----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:46:50 02/05/2014 
-- Design Name: 
-- Module Name:    inverter - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity inverter is
    Port ( I : in  STD_LOGIC;
           O : out  STD_LOGIC);
end inverter;

architecture Behavioral of inverter is
 component inverter
 Port    ( I : in  STD_LOGIC;
           O : out  STD_LOGIC
			  );
			  End component;

begin
O  <= not I;

end Behavioral;
