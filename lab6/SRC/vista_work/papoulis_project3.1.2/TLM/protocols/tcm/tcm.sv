
//************************************************************
//                                                            
//      Copyright Mentor Graphics Corporation 2006 - 2011     
//                  All Rights Reserved                       
//                                                            
//       THIS WORK CONTAINS TRADE SECRET AND PROPRIETARY      
//         INFORMATION WHICH IS THE PROPERTY OF MENTOR        
//         GRAPHICS CORPORATION OR ITS LICENSORS AND IS       
//                 SUBJECT TO LICENSE TERMS.                  
//                                                            
//************************************************************


// Generated by Model Builder 

module tcm_protocol
#(
    parameter ADDR_WIDTH = 15,
    parameter DATA_WIDTH = 72,
    parameter CYCLE_ACCURATE = 0, 
    string	__portPath = "",
    parameter	int	__portCount = 0,
    parameter	string	__snapshotPath = "",
    parameter	int	__timeFactor = 1
)

  (
    input DUMMY, 
    (*	clk	*)	input	CLK, 
    (*	master	*)	input	TCMCS, 
    (*	master	=	0	*)	input	TCMnRW, 
    (*	master	*)	input	[ADDR_WIDTH - 1:0]	TCMADDR	/* isAddress = 1 */, 
    (*	slave	*)	input	[DATA_WIDTH - 1:0]	TCMRD	/* isAddress = 0 */, 
    (*	master	*)	input	[DATA_WIDTH - 1:0]	TCMWD	/* isAddress = 0 */, 
    (*	master	=	1	*)	input	[7:0]	TCMWE	/* isAddress = 0 */, 
    (*	slave	=	0	*)	input	TCMWAIT
  );

chandle __pMessageHandler;
chandle __pPort;
import "DPI-C" pure function void Papoulis_ReadVCD_ProtocolError(input string reason, input string functionName, input longint unsigned stime, input chandle pMessageHandler);

`ifdef OPEN_ARRAYS  
import "DPI-C" function void Papoulis_ReadVCD_SendMessage(
`else
import "DPI-C" function void Papoulis_ReadVCD_OldSendMessage(
`endif
input chandle pMessageHandler, input chandle pPort, input string messageName, input longint unsigned stime
`ifdef OPEN_ARRAYS  
, input longint unsigned paramArray []
`else
, input longint unsigned p1, input longint unsigned p2, input longint unsigned p3, input longint unsigned p4
`endif
);


import "DPI-C" function chandle Papoulis_ReadVCD_GetPortHandle(input chandle pMessageHandler, input string portPath);
import "DPI-C" function chandle Papoulis_ReadVCD_GetMessageHandler(input string snapshotPath, input int factor);


import "DPI-C" pure function int Papoulis_ReadVCD_CycleTimeSet(input chandle pMessageHandler, input string portPath, input longint unsigned low, input longint unsigned high);
import "DPI-C" pure function void Papoulis_ReadVCD_SaveCycleClkTime( input chandle pMessageHandler, input chandle pPort, input longint unsigned low, input longint unsigned high);
task findCycleTime();
    time currentTime;
    time lowTime;
    time highTime;
    integer isAlreadySet; 
    
    isAlreadySet	=	0;
begin
    while (!isAlreadySet) 
    begin
        @(negedge CLK);
        currentTime = $time;
        @(posedge CLK);
        lowTime = $time - currentTime;
        currentTime = $time;
        @(negedge CLK);
        highTime = $time - currentTime;
        isAlreadySet = Papoulis_ReadVCD_CycleTimeSet(__pMessageHandler, __portPath, lowTime, highTime);
    end
    Papoulis_ReadVCD_SaveCycleClkTime(__pMessageHandler, __pPort, lowTime, highTime);
end
endtask

initial
	findCycleTime();

reg past_TCMWAIT;

function void REQUEST();
`ifdef OPEN_ARRAYS  
	longint unsigned paramArray [0 : 3];
	paramArray[0] = 0;
	paramArray[1] = 0;
	paramArray[2] = 0;
	paramArray[3] = 0;
`endif
`ifdef OPEN_ARRAYS  
	Papoulis_ReadVCD_SendMessage(__pMessageHandler, __pPort, "REQUEST", $time
`else
	Papoulis_ReadVCD_OldSendMessage(__pMessageHandler, __pPort, "REQUEST", $time
`endif
`ifdef OPEN_ARRAYS  
, paramArray
`else
, 0, 0, 0, 0
`endif
);
endfunction


function void READ_REQ(input longint unsigned TCMADDR);
`ifdef OPEN_ARRAYS  
	longint unsigned paramArray [0 : 3];
	paramArray[0] = TCMADDR;
	paramArray[1] = 0;
	paramArray[2] = 0;
	paramArray[3] = 0;
`endif
`ifdef OPEN_ARRAYS  
	Papoulis_ReadVCD_SendMessage(__pMessageHandler, __pPort, "READ_REQ", $time
`else
	Papoulis_ReadVCD_OldSendMessage(__pMessageHandler, __pPort, "READ_REQ", $time
`endif
`ifdef OPEN_ARRAYS  
, paramArray
`else
, TCMADDR, 0, 0, 0
`endif
);
endfunction


function void read_ack(input longint unsigned TCMRD, input longint unsigned BSize);
`ifdef OPEN_ARRAYS  
	longint unsigned paramArray [0 : 3];
	paramArray[0] = TCMRD;
	paramArray[1] = BSize;
	paramArray[2] = 1;
	paramArray[3] = 0;
`endif
`ifdef OPEN_ARRAYS  
	Papoulis_ReadVCD_SendMessage(__pMessageHandler, __pPort, "read_ack", $time
`else
	Papoulis_ReadVCD_OldSendMessage(__pMessageHandler, __pPort, "read_ack", $time
`endif
`ifdef OPEN_ARRAYS  
, paramArray
`else
, TCMRD, BSize, 1, 0
`endif
);
endfunction


function void WRITE_REQ(input longint unsigned TCMADDR, input longint unsigned TCMWD, input longint unsigned TCMWE, input longint unsigned BSize);
`ifdef OPEN_ARRAYS  
	longint unsigned paramArray [0 : 3];
	paramArray[0] = TCMADDR;
	paramArray[1] = TCMWD;
	paramArray[2] = TCMWE;
	paramArray[3] = BSize;
`endif
`ifdef OPEN_ARRAYS  
	Papoulis_ReadVCD_SendMessage(__pMessageHandler, __pPort, "WRITE_REQ", $time
`else
	Papoulis_ReadVCD_OldSendMessage(__pMessageHandler, __pPort, "WRITE_REQ", $time
`endif
`ifdef OPEN_ARRAYS  
, paramArray
`else
, TCMADDR, TCMWD, TCMWE, BSize
`endif
);
endfunction


function void write_ack();
`ifdef OPEN_ARRAYS  
	longint unsigned paramArray [0 : 3];
	paramArray[0] = 1;
	paramArray[1] = 0;
	paramArray[2] = 0;
	paramArray[3] = 0;
`endif
`ifdef OPEN_ARRAYS  
	Papoulis_ReadVCD_SendMessage(__pMessageHandler, __pPort, "write_ack", $time
`else
	Papoulis_ReadVCD_OldSendMessage(__pMessageHandler, __pPort, "write_ack", $time
`endif
`ifdef OPEN_ARRAYS  
, paramArray
`else
, 1, 0, 0, 0
`endif
);
endfunction


function void END_READ_TRANSACTION();
`ifdef OPEN_ARRAYS  
	longint unsigned paramArray [0 : 3];
	paramArray[0] = 0;
	paramArray[1] = 0;
	paramArray[2] = 0;
	paramArray[3] = 0;
`endif
`ifdef OPEN_ARRAYS  
	Papoulis_ReadVCD_SendMessage(__pMessageHandler, __pPort, "END_READ_TRANSACTION", $time
`else
	Papoulis_ReadVCD_OldSendMessage(__pMessageHandler, __pPort, "END_READ_TRANSACTION", $time
`endif
`ifdef OPEN_ARRAYS  
, paramArray
`else
, 0, 0, 0, 0
`endif
);
endfunction


function void END_WRITE_TRANSACTION();
`ifdef OPEN_ARRAYS  
	longint unsigned paramArray [0 : 3];
	paramArray[0] = 0;
	paramArray[1] = 0;
	paramArray[2] = 0;
	paramArray[3] = 0;
`endif
`ifdef OPEN_ARRAYS  
	Papoulis_ReadVCD_SendMessage(__pMessageHandler, __pPort, "END_WRITE_TRANSACTION", $time
`else
	Papoulis_ReadVCD_OldSendMessage(__pMessageHandler, __pPort, "END_WRITE_TRANSACTION", $time
`endif
`ifdef OPEN_ARRAYS  
, paramArray
`else
, 0, 0, 0, 0
`endif
);
endfunction


function void idle();
`ifdef OPEN_ARRAYS  
	longint unsigned paramArray [0 : 3];
	paramArray[0] = 1;
	paramArray[1] = 0;
	paramArray[2] = 0;
	paramArray[3] = 0;
`endif
`ifdef OPEN_ARRAYS  
	Papoulis_ReadVCD_SendMessage(__pMessageHandler, __pPort, "idle", $time
`else
	Papoulis_ReadVCD_OldSendMessage(__pMessageHandler, __pPort, "idle", $time
`endif
`ifdef OPEN_ARRAYS  
, paramArray
`else
, 1, 0, 0, 0
`endif
);
endfunction


function void protocolError;
input error;
string error;
$display($time," --> ERROR in %m");
Papoulis_ReadVCD_ProtocolError(error, "protocolError", $time, __pMessageHandler);
endfunction

typedef enum int {IDLE=0, BRANCH, READ_WAIT, WRITE_WAIT}  PROTOCOL_STATES;
PROTOCOL_STATES protocolState;
(* protocol_initial *)
initial
    protocolState = IDLE;
initial
begin
    __pMessageHandler = Papoulis_ReadVCD_GetMessageHandler(__snapshotPath, __timeFactor);
    __pPort = Papoulis_ReadVCD_GetPortHandle(__pMessageHandler, __portPath);
    while(1)
begin 
    case (protocolState)
    IDLE:
        begin 
            if ((TCMCS!==1'bx))
            begin 
                protocolState = BRANCH;
                (* READ *)
                (* WRITE *)
                (* IDLE_CYCLE *)
                REQUEST();
            end
            else
            begin 
                protocolState = IDLE;
                @(negedge CLK)
                    ;
            end
        end
    BRANCH:
        begin 
            if ((TCMCS!=1))
            begin 
                (* IDLE_CYCLE *)
                idle();
                protocolState = IDLE;
                @(negedge CLK)
                    ;
            end
            else
                if (((TCMnRW==0)&&(TCMWE==0)))
                begin 
                    past_TCMWAIT = TCMWAIT;
                    protocolState = READ_WAIT;
                    (* READ *)
                    READ_REQ(TCMADDR);
                    @(negedge CLK)
                        ;
                end
                else
                    if ((TCMnRW==1))
                    begin 
                        past_TCMWAIT = TCMWAIT;
                        protocolState = WRITE_WAIT;
                        (* WRITE *)
                        WRITE_REQ(TCMADDR,TCMWD,TCMWE,1);
                        @(negedge CLK)
                            ;
                    end
                    else
                    begin 
                        protocolError("protocol tcm sequence is wrong in state BRANCH");
                        @(negedge CLK)
                            ;
                    end
        end
    READ_WAIT:
        begin 
            if ((past_TCMWAIT==1))
            begin 
                past_TCMWAIT = TCMWAIT;
                protocolState = READ_WAIT;
                @(negedge CLK)
                    ;
            end
            else
            begin 
                protocolState = IDLE;
                read_ack(TCMRD,1);
            end
        end
    WRITE_WAIT:
        begin 
            if ((past_TCMWAIT==1))
            begin 
                past_TCMWAIT = TCMWAIT;
                protocolState = WRITE_WAIT;
                @(negedge CLK)
                    ;
            end
            else
            begin 
                protocolState = IDLE;
                write_ack();
            end
        end
    endcase
end
end
endmodule