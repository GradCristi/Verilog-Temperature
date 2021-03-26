
//are rolul de a instantia blocurile si de a realiza conexiunile necesare

module temperature_top (  

		output [7:0] led_output_o,     	//iesire pentru aprinderea fiecarui led
		output alert_o,			//semnalul de alerta(este 1 daca iesirea este aprox in exteriorul 19:26)
		input [39:0] sensors_data_i,   	// val de temperatura
		input [4:0] sensors_en_i); 	//bit de enable, daca este 1 atunci este pregatit de citire

			wire [15:0] temp;
			wire [7:0] activesensors;
			wire[15:0] q;		
			wire [15:0] r;
			wire [7:0] coded_out;
			reg [15:0] activesensors16bit;
			integer i;

			sensors_input s(temp, activesensors, sensors_data_i, sensors_en_i);    	//instantierea primului modul
			always@(*) begin							//trecem activesensors pe 16 biti ca sa poata fi utilizat de division
				for(i=0; i<=15; i=i+1) begin
					activesensors16bit[i]=0;				//il umplem cu 0
				end
				activesensors16bit=activesensors;				//si inscriem valoarea vechiului activesensors 
			end

			division d(q, r, temp, activesensors16bit);				//instantierea modului de division
			output_display o(led_output_o, alert_o, q, r, activesensors);		//instantierea modulului de output display
endmodule