`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Nafis Ul Haque
// 
// Create Date: 11/05/2020 01:39:51 PM
// Design Name: 
// Module Name: mips
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


/*registers*/
module reg_file(
    // clock and reset
    input clk,
    input rst,
    //read side
    input [4:0] regA_addr,
    input [4:0] regB_addr,
    output [31:0] regA_data,
    output [31:0] regB_data,
    //write side
    input [4:0] regW_addr,
    input [31:0] regW_data,
    input wrtEn    
    );
    
    reg [31:0] registers [31:0];
    integer i;
    
    always@(posedge clk)
    begin
        if(rst)
        begin
            for(i = 0; i < 32; i = 1 + i)
                registers[i] <= 32'd0;
        end
        
        else
        begin
            if(wrtEn)
            begin
                registers[regW_addr] <= regW_data;
            end
        end    
    end
    
assign regA_data = (regA_addr == 5'd0) ? registers[0]:
                   (regA_addr == 5'd1) ? registers[1]:
                   (regA_addr == 5'd2) ? registers[2]:
                   (regA_addr == 5'd3) ? registers[3]:
                   (regA_addr == 5'd4) ? registers[4]:
                   (regA_addr == 5'd5) ? registers[5]:
                   (regA_addr == 5'd6) ? registers[6]:
                   (regA_addr == 5'd7) ? registers[7]:
                   (regA_addr == 5'd8) ? registers[8]:
                   (regA_addr == 5'd9) ? registers[9]:
                   (regA_addr == 5'd10) ? registers[10]:
                   (regA_addr == 5'd11) ? registers[11]:
                   (regA_addr == 5'd12) ? registers[12]:
                   (regA_addr == 5'd13) ? registers[13]:
                   (regA_addr == 5'd14) ? registers[14]:
                   (regA_addr == 5'd15) ? registers[15]:
                   (regA_addr == 5'd16) ? registers[16]:
                   (regA_addr == 5'd17) ? registers[17]:
                   (regA_addr == 5'd18) ? registers[18]:
                   (regA_addr == 5'd19) ? registers[19]:
                   (regA_addr == 5'd20) ? registers[20]:
                   (regA_addr == 5'd21) ? registers[21]:
                   (regA_addr == 5'd22) ? registers[22]:
                   (regA_addr == 5'd23) ? registers[23]:
                   (regA_addr == 5'd24) ? registers[24]:
                   (regA_addr == 5'd25) ? registers[25]:
                   (regA_addr == 5'd26) ? registers[26]:
                   (regA_addr == 5'd27) ? registers[27]:
                   (regA_addr == 5'd28) ? registers[28]:
                   (regA_addr == 5'd29) ? registers[29]:
                   (regA_addr == 5'd30) ? registers[30]: 
                                          registers[31];
                   

assign regB_data = (regB_addr == 5'd0) ? registers[0]:
                   (regB_addr == 5'd1) ? registers[1]:
                   (regB_addr == 5'd2) ? registers[2]:
                   (regB_addr == 5'd3) ? registers[3]:
                   (regB_addr == 5'd4) ? registers[4]:
                   (regB_addr == 5'd5) ? registers[5]:
                   (regB_addr == 5'd6) ? registers[6]:
                   (regB_addr == 5'd7) ? registers[7]:
                   (regB_addr == 5'd8) ? registers[8]:
                   (regB_addr == 5'd9) ? registers[9]:
                   (regB_addr == 5'd10) ? registers[10]:
                   (regB_addr == 5'd11) ? registers[11]:
                   (regB_addr == 5'd12) ? registers[12]:
                   (regB_addr == 5'd13) ? registers[13]:
                   (regB_addr == 5'd14) ? registers[14]:
                   (regB_addr == 5'd15) ? registers[15]:
                   (regB_addr == 5'd16) ? registers[16]:
                   (regB_addr == 5'd17) ? registers[17]:
                   (regB_addr == 5'd18) ? registers[18]:
                   (regB_addr == 5'd19) ? registers[19]:
                   (regB_addr == 5'd20) ? registers[20]:
                   (regB_addr == 5'd21) ? registers[21]:
                   (regB_addr == 5'd22) ? registers[22]:
                   (regB_addr == 5'd23) ? registers[23]:
                   (regB_addr == 5'd24) ? registers[24]:
                   (regB_addr == 5'd25) ? registers[25]:
                   (regB_addr == 5'd26) ? registers[26]:
                   (regB_addr == 5'd27) ? registers[27]:
                   (regB_addr == 5'd28) ? registers[28]:
                   (regB_addr == 5'd29) ? registers[29]:
                   (regB_addr == 5'd30) ? registers[30]: 
                                          registers[31];
endmodule

//insstruction memory
module Imem (
    // clock and reset
    input clk,
    input rst,
    //read side
    input [31:0] addr,
    output [31:0] instr 
    );
    
    reg [31:0] instructions [1023:0];
    integer i;
    always@(posedge clk)
    begin
        if(rst)
        begin
            for(i = 0; i < 1024; i = 1 + i)
                instructions[i] <= 32'b0;
        end
    end
    
assign instr = instructions[addr];
                   


    
endmodule

module Dmem(
    // clock and reset
    input clk,
    input rst,
    //read side
    input [31:0] mem_addr,
    output [31:0] mem_data,
    //write side
    input [31:0] wrt_data,
    input wrtEn    
    );
    
    reg [31:0] memory [1023:0];
    integer i;
    
    always@(posedge clk)
    begin
        if(rst)
        begin
            for(i = 0; i < 1024; i = 1 + i)
                memory[i] <= 32'd0;
        end
        
        else
        begin
            if(wrtEn)
            begin
                memory[mem_addr] <= wrt_data;
            end
        end    
    end
    
assign mem_data = memory[mem_addr];
                   
endmodule

//Basic ALU with ADD, SUB, AND, OR, XOR, NOR and SLT
module ALU(
    input [5:0] funct,
    input [31:0] a,
    input [31:0] b,
    output flg,
    output [31:0] res
    );
    
    assign res = (funct == 000001) ? (a + b) : //ADD
                 (funct == 000010) ? a - b : //SUB
                 (funct == 000011) ? a & b : //AND
                 (funct == 000100) ? a | b : //OR
                 (funct == 000101) ? a ^ b : //XOR
                 (funct == 000110) ? a ~^ b : //XNOR
                 (funct == 000111) ? (a): // LDR
                                     (32'd0); //NOP
                                     
    assign flg = (res == 32'd0) ? 1'b1 : 1'b0;
                 
    
endmodule

module mips(
    input clk,
    input rst
    );
    
    reg [31:0] pc;
    wire [31:0] instr;
    
    
    
    Imem instructions(
    // clock and reset
    .clk(clk),
    .rst(rst),
    //read side
    /*input*/ .addr(pc),
    /*output*/ .instr(instr) 
    );
    
    // Control Wires
    wire ctrl = instr[31:26];
    wire RegDst;
    wire Jump;
    wire Branch;
    wire MemRead;
    reg MemtoReg;
    wire ALUOp;
    wire MemWrite;
    wire ALUSrc;
    reg RegWrite;
    
    
    // Wires for register
    wire [4:0] registers_wrt_addr = (RegDst) ? instr[20:16] : instr[15:11];
    wire [31:0] regA_data;
    wire [31:0] regB_data;
    wire [31:0] mem_data;
    wire [31:0] res;
    wire [31:0] DatatoReg = (MemtoReg)? mem_data : res;
    reg_file registers(
    // clock and reset
    .clk(clk),
    .rst(rst),
    //read side
    .regA_addr(instr[25:21]),
    .regB_addr(instr[20:16]),
    .regA_data(regA_data),
    .regB_data(regB_data),
    //write side
    .regW_addr(registers_wrt_addr),
    .regW_data(DatatoReg),
    .wrtEn(RegWrite)    
    );
    
    wire imm = { {16{instr[15]}}, instr[15:0]};
    wire [31:0] b_data = (ALUSrc) ? { {16{instr[15]}}, instr[15:0]} : regB_data; //Confused if it is working or not
    wire z_flg;
    ALU alu(
    /*input [5:0] */ .funct(instr[5:0]),
    /*input [31:0]*/ .a(regA_data),
    /*input [31:0]*/ .b(b_data),
    /*output */.flg(z_flg),
    /*output [31:0]*/ .res(res)
    );
    
    
    
    Dmem data_mem (
    // clock and reset
    /*input*/ .clk(clk),
    /*input*/ .rst(rst),
    //read side
    /*input [31:0]*/ .mem_addr(res),
    /*output [31:0]*/ .mem_data(mem_data),
    //write side
    /*input [31:0]*/ .wrt_data(regB_data),
    /*input */.wrtEn(MemWrite)    
    );
    
    //Upperportion
    wire [31:0] wire_1; //Connected to adder_1
    wire brnchEn = Branch & z_flg; //Enables branch
    wire [31:0] added_PC; // Next PC instruction
    
    
    ALU adder_1(
    /*input [5:0] */ .funct(6'b000001),
    /*input [31:0]*/ .a(pc),
    /*input [31:0]*/ .b(6'd4),
    /*output */.flg(),
    /*output [31:0]*/ .res(added_PC)
    );
    
    
    ALU adder_2(
    /*input [5:0] */ .funct(6'b000001),
    /*input [31:0]*/ .a(added_PC),
    /*input [31:0]*/ .b(imm << 2),
    /*output */.flg(),
    /*output [31:0]*/ .res(wire_1)
    );
    wire [31:0] branch_wire = (brnchEn) ? wire_1 : added_PC;
    
    wire [31:0] jump_wire = {added_PC[31:28],(instr[25:0] << 2)};
    wire [31:0] next_PC = (Jump) ? jump_wire : branch_wire;
    integer i;
    
    always@(posedge clk)
    begin
        if(rst)
        begin
            for(i = 0; i < 32; i = 1 + i)
                pc <= next_PC;
        end   
    end    
    
endmodule
