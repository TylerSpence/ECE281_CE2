ECE281_CE2
==========

#Truth Table

|  I0 |  I1  |  EN  |  Y0  |  Y1  |  Y2  | Y3 |
|--:|--: |--: |--:| --:| --:| --:|
|  0 |  0  |  0  |   0 |   0 |   0 |  0  |
|  0 |  0  |  1  |   1 |   0 |   0 |  0  |
|  0 |  1  |  0  |   0 |   0 |   0 |  0  |
|  0 |  1  |  1  |   0 |   0 |   1 |  0  |
|  1 |  0  |  0  |   0 |   0 |   0 |  0  |
|  1 |  0  |  1  |   0 |   1 |   0 |  0  |
|  1 |  1  |  0  |   0 |   0 |   0 |  0  |
|  1 |  1  |  1  |   0 |   0 |   0 |  1  |

#Analysis of Structural Waveform:
![alt tag] (https://raw2.github.com/TylerSpence/ECE281_CE2/master/screenshot%20structural.png)

#Analysis of Behavioral Waveform:
![alt tag] (https://raw2.github.com/TylerSpence/ECE281_CE2/master/screenshot%20behavioral.png)

The results of both waveforms are nearly identical, indicating that both versions of the decoder program perform the same function. 

#Code of the Structural Decoder
The most important distinction between the structural and behavioral versions are the component declarations in the structrual version. 
```VHDL
component and3
 Port    ( I0 : in  STD_LOGIC;
           I1 : in  STD_LOGIC;
           I2 : in  STD_LOGIC;
           O : out  STD_LOGIC
			  );
			  End component;

component inverter
 Port    ( I : in  STD_LOGIC;
           O : out  STD_LOGIC
			  );
			  End component;
```
Then, using these component declarations, the various components needed for the circuit are defined.
```VHDL
 begin
Y0_and3: and3 PORT MAP(
  I0 => I0_NOT,
  I1 => I1_NOT,
  I2 => EN,
  O => Y0
 );
 
 Y1_and3: and3 PORT MAP(
  I0 => I0,
  I1 => I1_NOT,
  I2 => EN,
  O => Y1
 );
 
 Y2_and3: and3 PORT MAP(
  I0 => I0_NOT,
  I1 => I1,
  I2 => EN,
  O => Y2
 );
 
 Y3_and3: and3 PORT MAP(
  I0 => I0,
  I1 => I1,
  I2 => EN,
  O => Y3
 );

 I0_inverter: inverter PORT MAP(
  I => I0,
  O => I0_NOT
 );

 I1_inverter: inverter PORT MAP(
  I => I1,
  O => I1_NOT
 );
end Structural;
```
#Code of the Behavioral Decoder
The behavioral decoder merely required two signal declarations within the architecture section. Under the begin section, the logic was assigned in accordance with the following sop equations.

Y0= (I0') * (I1') * (EN) 

Y1= (I0) * (I1') * (EN)

Y2= (I0') * (I1) * (EN)

Y3= (I0) * (I1) * (EN)

```Vhdl
architecture Behavioral of CE2_Behavioral is
signal I0_Not,I1_Not : STD_LOGIC;
begin
I0_Not <= not I0;
I1_Not <= not I1;
Y0 <= I0_Not and I1_Not and EN;
Y1 <= I0 and I1_Not and EN;
Y2 <= I0_Not and I1 and EN;
Y3 <= I0 and I1 and EN;
```
#Testbench code
The code for the testbenches for the behavioral and structural versions is the same. All iterations of the truth table were done and a self check program (demonstrated below) displayed an error report if the graph deviated from extected values.
```VHDL
I0 <= '0';
I1 <= '0';
EN <= '0';
wait for 1 ns;
Assert Y0 = '0' Report "String to output if assertion fails" Severity ERROR;
Assert Y1 = '0' Report "String to output if assertion fails" Severity ERROR;
Assert Y2 = '0' Report "String to output if assertion fails" Severity ERROR;
Assert Y3 = '0' Report "String to output if assertion fails" Severity ERROR;
```


#Debugging
When creating the self test code for the testbench, several errors were displayed when they shouldn't have been. This was solved by adding an additional wait command to move the assert check away from the border of where the two different iterations of the truth table interacted with each other. 

#Functionality of the Decoder
The decoder works in a very interesting way. When the ecoder is turned on (EN=1) then the two digit binary number represented by I0 and I1 is converted to the decimal output. For example, when EN=1, I0=1, and I1=0, the binary number created by I0 and I1 is 10, which corresponds to the decimal number 2. The decoder demonstrates this by having an output of 1 in Y2! The 2 is the decimal number represented by the binary number! When the output of I1 and I0 is 11 (decimal 3) then Y3 is activated.
This has very large potential when replicated on large scale, creating the potential for multiple inputs, such as that found on a keyboard. 
