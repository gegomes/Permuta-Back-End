DROP PROCEDURE IF EXISTS PROCEDURE_CADASTRAR_O_QUE_USUARIO_DESEJA;

DELIMITER //
	CREATE PROCEDURE PROCEDURE_CADASTRAR_O_QUE_USUARIO_DESEJA(
		IN INPUT_CITIE_ID INT(11),
		IN INPUT_CUSTOMERS_ID INT(11),
		IN INPUT_BEDROOMS VARCHAR(1),
		IN INPUT_TOTAL_AREA INT(11),
		IN INPUT_USEFUL_AREA INT(11),
		IN INPUT_PROPERTY_INITIAL_VALUE INT(11),
		IN INPUT_FINAL_PROPERTY_VALUE INT(11)
		BEGIN
			-- DECLARE VIEW_RETUNS;
		    INSERT INTO what_the_customer_wants 
			 		(citie_id,customers_id, bedrooms,total_area,useful_area,property_initial_value,final_property_value) 
			VALUES 
					(INPUT_CITIE_ID,INPUT_CUSTOMERS_ID,INPUT_BEDROOMS,INPUT_TOTAL_AREA,INPUT_USEFUL_AREA,INPUT_PROPERTY_INITIAL_VALUE,INPUT_FINAL_PROPERTY_VALUE);
			
			COMMIT;	
			IF LAST_INSERT_ID() != FALSE THEN
					SELECT WS.*, C.name,C.phone, C.email FROM what_the_customer_has AS WS
						INNER JOIN customers AS C ON WS.customers_id = C.id
					WHERE WS.citie_id = INPUT_CITIE_ID 
						AND (WS.bedrooms >= INPUT_BEDROOMS AND WS.bedrooms <= (INPUT_BEDROOMS+2))
						AND (WS.total_area >= INPUT_TOTAL_AREA OR WS.total_area <= ((INPUT_TOTAL_AREA*30)/100)+INPUT_TOTAL_AREA) 
						AND (WS.useful_area >= INPUT_USEFUL_AREA OR  WS.useful_area <= ((INPUT_USEFUL_AREA*30)/100)+INPUT_USEFUL_AREA) 
						AND (WS.property_initial_value >= INPUT_PROPERTY_INITIAL_VALUE OR WS.property_initial_value <= ((INPUT_PROPERTY_INITIAL_VALUE*30)/100) +INPUT_PROPERTY_INITIAL_VALUE)
						AND (WS.final_property_value >= INPUT_FINAL_PROPERTY_VALUE OR WS.final_property_value <= ((INPUT_FINAL_PROPERTY_VALUE*30)/100) + INPUT_FINAL_PROPERTY_VALUE)
						AND WS.customers_id != INPUT_CUSTOMERS_ID
						AND WS.is_active = 1;
			ELSE
    			ROLLBACK;
				SELECT "ERROR";
			END IF;							
		    
		END //
DELIMITER ;


 CALL PROCEDURE_CADASTRAR_O_QUE_USUARIO_DESEJA(883,1,'1',30,60,49000,770000);



/*SELECT WS.*, C.name,C.phone, C.email FROM what_the_customer_has AS WS
					INNER JOIN customers AS C ON WS.customers_id = C.id
					WHERE WS.citie_id = 883 AND (WS.bedrooms >= 3 AND WS.bedrooms <= (3+2))
 					AND (WS.total_area >= 30 OR WS.total_area <= ((30*30)/100)+30) 
					AND (WS.useful_area >= 60 OR  WS.useful_area <= ((60*30)/100)+30) 
					AND (WS.property_initial_value >= 51000 OR WS.property_initial_value <= ((51000*30)/100) +51000)
					AND (WS.final_property_value >= 770000 OR WS.final_property_value <= ((770000*30)/100) + 770000 )
					AND WS.customers_id != 1
/*

 CALL PROCEDURE_CADASTRAR_O_QUE_USUARIO_DESEJA(883,1,'3',100,200,49000,770000);
 
 
 
 SELECT WS.*, C.name,C.phone, C.email FROM what_the_customer_has AS WS
					INNER JOIN customers AS C ON WS.customers_id = C.id
					WHERE WS.citie_id = 883 
					OR (WS.bedrooms >= 3 AND WS.bedrooms <= (3+1))
 					OR (WS.total_area >= 21 AND WS.total_area <= ((21*30)/100)+30) 
					OR (WS.useful_area >= 60 AND  WS.useful_area <= ((60*30)/100)+30)
					AND (WS.property_initial_value >= 51000 OR WS.property_initial_value <= ((51000*30)/100) +51000)
					AND (WS.final_property_value >= 770000 OR WS.final_property_value <= ((770000*30)/100) + 770000 )
					AND WS.customers_id != 1

