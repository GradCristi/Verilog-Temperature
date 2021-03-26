`timescale 1ns / 1ps

//furnizeaza suma si nr de senzori pentru media aritmetica din division

module sensors_input (
	output reg [15:0] temp_sum_o,      		//suma temperaturilor valide
	output reg [7:0] nr_active_sensors_o,		//nr senzori activi
	input [39:0] sensors_data_i,			//valorile de temp ale senzorilor
	input [4:0] sensors_en_i);			//bit enable senzor

		integer i;
		always@(*) begin
			temp_sum_o=0;				//intitalizez cu 0 ca sa nu intampinam probleme mai incolo
			nr_active_sensors_o=0;
			for(i=0; i<5; i=i+1) begin         	//5 senzori    
				if(sensors_en_i[i]==1) begin	//daca bitul enable e on
					temp_sum_o= temp_sum_o+ sensors_data_i[8*i +: 8];		//adaugam in grupuri de cate 8
					nr_active_sensors_o=nr_active_sensors_o+1;			//crestem nr de senzori care au participat la suma
				end
			end
		end



endmodule
