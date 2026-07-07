`include "defines.sv"
class ram_reference_model;
   ram_transaction ref_trans;
   mailbox #(ram_transaction) mbx_rs;
   mailbox #(ram_transaction) mbx_dr;
   virtual ram_if.REF_SB vif;
   bit [7:0] MEM [31:0];


  function new(mailbox #(ram_transaction) mbx_dr,
               mailbox #(ram_transaction) mbx_rs,
               virtual ram_if.REF_SB vif);
    this.mbx_dr=mbx_dr;
    this.mbx_rs=mbx_rs;
    this.vif=vif;
  endfunction


  task start();
    for(int i=0;i<`no_of_trans;i++)
     begin
      ref_trans=new();
     if(vif.ref_cb.reset==0) begin
      foreach (MEM[i])
       MEM[i]=0;
       ref_trans.data_out = 8'bz;
        end
    
      mbx_dr.get(ref_trans);
      repeat(1) @(vif.ref_cb);
      
      
         if(vif.ref_cb.reset==0) begin
      foreach (MEM[i])
       MEM[i]=0;
       ref_trans.data_out = 8'bz;
        end
	else begin
        if(ref_trans.write_enb && !(ref_trans.read_enb)) begin
         MEM[ref_trans.address]=ref_trans.data_in;
	 ref_trans.data_out = 8'bz;
        $display("REFERENCE MODEL DATA IN MEMORY MEM[ADDRESS]=%d",MEM[ref_trans.address],$time);
	end

        if(ref_trans.read_enb && !ref_trans.write_enb) begin
         ref_trans.data_out=MEM[ref_trans.address];
        $display("REFERENCE MODEL DATA OUT FROM MEMORY data_out=%d",ref_trans.data_out,$time);
      
	end
     end

      mbx_rs.put(ref_trans);
      
     end 
  endtask
endclass
 

