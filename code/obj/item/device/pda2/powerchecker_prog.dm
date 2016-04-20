//PDA program for displaying engine data and laser output. By FishDance
//Note: Could display weird results if there is more than one engine or PTL around. 
/datum/computer/file/pda_program/power_checker
	name = "Power Checker 0.14"
	size = 4
	
	var/obj/machinery/atmospherics/binary/circulatorTemp/circ1
	var/obj/machinery/atmospherics/binary/circulatorTemp/right/circ2
	var/obj/machinery/power/pt_laser/laser
	var/obj/machinery/power/generatorTemp/generator

	return_text()
		if(..())
			return
		if (!laser)
			laser = locate(/obj/machinery/power/pt_laser) in machines
		if (!generator)
			generator = locate(/obj/machinery/power/generatorTemp) in machines
		if (!circ1)
			circ1 = generator.circ1
		if (!circ2)
			circ2 = generator.circ2


		var/stuff = src.return_text_header()

		if (generator)
			stuff += "<BR><B>Thermo-Electric Generator Status</B><BR>"
			stuff += "Output : [engineering_notation(generator.lastgen)]W<BR>"
			stuff += "<BR>"

			stuff += "<B>Hot Loop</B><BR>"
			stuff += "Temperature Inlet: [round(circ1.air1.temperature, 0.1)] K  Outlet: [round(circ1.air2.temperature, 0.1)] K<BR>" 
			stuff += "Pressure Inlet: [round(circ1.air1.return_pressure(), 0.1)] kPa  Outlet: [round(circ1.air2.return_pressure(), 0.1)] kPa<BR>" 
			stuff += "<BR>"
			
			stuff += "<B>Cold Loop</B><BR>"
			stuff += "Temperature Inlet: [round(circ2.air1.temperature, 0.1)] K  Outlet: [round(circ2.air2.temperature, 0.1)] K<BR>" 
			stuff += "Pressure Inlet: [round(circ2.air1.return_pressure(), 0.1)] kPa  Outlet: [round(circ2.air2.return_pressure(), 0.1)] kPa<BR>"
			stuff += "<BR>"
		else
			stuff += "Error! No engine detected!<BR><BR>"
		if (laser)
			stuff += "<B>Power Transmition Laser Status</B><BR>"
			stuff += "Currently Active: "

			if(laser.firing)
				stuff += "Yes<BR>"
			else
				stuff += "No<BR>"
		
			stuff += "Power Stored: [engineering_notation(laser.charge)]J ([round(100.0*laser.charge/laser.capacity, 0.1)]%)<BR>"
			stuff += "Power Input: [engineering_notation(laser.chargelevel)]W<BR>"
			stuff += "Power Output: [engineering_notation(laser.output)]W<BR>"
		else
			stuff += "Error! No PTL detected!"
		return stuff
