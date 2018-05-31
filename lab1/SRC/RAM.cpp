//===========================================
// Function : Asynchronous SRAM 
//===========================================
#include "systemc.h"

#define DATA_WIDTH        8 
#define ADDR_WIDTH        18 
#define RAM_DEPTH         1 << ADDR_WIDTH

SC_MODULE (RAM) 
{
	// ----- Declare Input/Output ports -----
	// Code Added by Chandrahas starts here
	sc_out <sc_uint<8> > OutData; // Output port for the Data which will be written from the memory
	sc_in <bool> bCE; // input control signal to the memory
	sc_in <bool> bWE; // input control signal to the memory
	sc_in <sc_uint<18> > Addr; // input memory address to the memory
	sc_in <sc_uint<8> > InData; // input address to the memory  

	// ----- Internal variables -----
	sc_uint<8>  sram_memory[262144]; // 256K bytes declared as an character array

	// ----- Code Starts Here ----- 
	// Memory Write Block
  	void sram_write()
  	{
  		// Write Operation : When we_b = 0, ce_b = 0
  		// ...
  		if((bWE.read()==0)&&(bCE.read()==0)) // Conditional Statement imposing the  required signal condition on bWE and bCE
  		{
  			sram_memory[Addr.read()] = InData.read(); // Copy the input data into the memory array 
  			// print off the information regarding the Write performed
  			cout << "Write Operation on SRAM: Address=" <<Addr.read()<<",Data="<<InData.read()<<",Data in SRAM ="<< sram_memory[Addr.read()]<<"\n";
  		}

  	}	 
  	
  	// Memory Read Block
  	void sram_read()
  	{
  		  // Read Operation : When we_b = 1, ce_b = 0
  		  // ...
  		  if((bWE.read()==1)&&(bCE.read()==0)) // Conditional Statement imposing the  required signal condition on bWE and bCE
  		  {
  		  	OutData.write(sram_memory[Addr.read()]); // Write the data to the output port from the Memory Array
  		  	// print off the information about the Read performed
  		  	cout << "Read Operation on SRAM: Address=" <<Addr.read()<<",Data in SRAM ="<< sram_memory[Addr.read()]<<"\n";
  		  }  		
  	} 

  	// ----- Constructor for the SC_MODULE -----
  	// sensitivity list
  	SC_CTOR(RAM) 
  	{
		SC_METHOD(sram_write); // Method registration
		sensitive << Addr << bWE << bCE << InData; // sensitivity list
		SC_METHOD(sram_read); // Method registration
		sensitive << Addr << bWE<< bCE << InData; // sensitivity list
	}
};
