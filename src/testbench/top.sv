module top( );
 
    import ram_pkg ::*; 

    bit clk;
    bit reset;


  initial
    begin
     forever #10 clk=~clk;
    end
 
  initial
    begin
      @(posedge clk);
	reset =1;
	repeat(5)@(posedge clk);
	reset =0;
      //reset=0;
      repeat(5)@(posedge clk);
      reset=1;
      
	


    end
 

    ram_if intrf(clk,reset);
  
    RAM DUV(.data_in(intrf.data_in),
            .write_enb(intrf.write_enb),
            .read_enb(intrf.read_enb),
            .data_out(intrf.data_out),
            .address(intrf.address),
            .clk(clk),
            .reset(reset)
           );

    ram_test tb= new(intrf.DRV,intrf.MON,intrf.REF_SB);
    test1 tb1= new(intrf.DRV,intrf.MON,intrf.REF_SB);
    test2 tb2= new(intrf.DRV,intrf.MON,intrf.REF_SB);
    test3 tb3= new(intrf.DRV,intrf.MON,intrf.REF_SB);
    test4 tb4= new(intrf.DRV,intrf.MON,intrf.REF_SB);
    test_regression tb_regression= new(intrf.DRV,intrf.MON,intrf.REF_SB);


  initial
   begin
    tb_regression.run();
    tb.run();
tb1.run();
tb2.run();
tb3.run();
tb4.run();
    $finish;
   end
endmodule
