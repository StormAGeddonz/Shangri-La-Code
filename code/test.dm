/client/verb/test_concept_lighting()
	set name = "Concept Lighting Test"
	set desc = "Concepts"

	for(var/obj/machinery/L in machinery)
		addOverlayLighting()

/proc/addOverlayLighting()
