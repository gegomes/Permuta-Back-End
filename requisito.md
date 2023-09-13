- TB_USUARIOS - consultores - admin
	id 
	email
	password
	is_active (TRUE,FALSE) DEFAULT(FALSE)
	tipo = admin - guest

- TB_CLIENTES
	id
	nome
	telefone
	email
- TB_ESTADOS
	id
	nome
	uf
-TB_CIDADES
	id
	id_estado
	nome
	
- TB_TIPO_IMOVEL
	id
	name
	
- TB_CLIENTE_TEM
	id
	id_tipo_imovel
	dormitorio enum('1','2','3','4','5','6')
	area_total
	area_util
	valor_inicial_imovel
	valor_final_imovel
	codigo_imovel

- TB_CLIENTE_QUER
	id
	id_tipo_imovel
	dormitorio enum('1','2','3','4','5','6')
	area_total
	area_util
	valor_inicial_imovel
	valor_final_imovel