`timescale 1ns / 1ps

//aprox valoarea medie a temperaturii si afiseaza informatia

module output_display (		

	output reg [7:0] coded_out_o,			//semnalul codificat pt iesire
	output reg alert_o,				//semnalul de alerta
	input [15:0] temp_Q_i,				//catul impartirii 
	input [15:0] temp_R_i,				//restul impartiri
	input [7:0] active_sensors_nr);			//nr de senzori

		integer i;
		reg [7:0] code;
		reg [15:0] temp;		//am declarat aceste variabile deoarece nu ma lasa sa lucrez direct cu temp_Q_i
	
		always@(*)begin
			temp=temp_Q_i;		//initializare
			code=0;
	
			if(2*temp_R_i>= active_sensors_nr) begin  	//daca depasim(sau egalam) pragul de 0.5 aproximam la valoarea superioara
				temp=temp+1;
			end
			if(temp<19) begin				//daca ma aflu in plaja de valori inferioara lui 19 voi afisa acelasi lucru indiferent de numarul exact
				coded_out_o=8'b00000001;
				alert_o=1;
			end  else if( temp>=19 && temp<=26) begin     	//daca ma aflu in zona corecta
						for( i=0; i<=7; i=i+1) begin
							code[i]=1;		//adaug 1 pe pozitia i pentru fiecare grad urcat de i
							if(temp==i+19) begin		//atunci cand am gasit temperatura accept codul generat pana acum si afisez alerta 0 pentru ca sunt in intervalul corect
								coded_out_o=code;
								alert_o=0;
							end
						end
					end else if( temp> 26) begin		//daca sunt pe plaja de valori superioara lui 26 afisez codul specific si alarma de depasire a valorii ideale
							coded_out_o=8'b11111111;
							alert_o=1;
						end						
		endendmodule
