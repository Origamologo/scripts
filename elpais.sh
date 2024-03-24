#!/bin/bash

read -p 'Introduce la url de la noticia: ' noticia

# curl $noticia > noticia.html && open noticia.html

# Guardar el código de la noticia
curl $noticia > noticia.html

# Sustituir el mensaje de subscripción por un string temporal
sed -i -e '/<div class="a_s _cf" id="ctn_freemium_article">/,/<\/div>/ {/<div class="a_s _cf" id="ctn_freemium_article">/! {/<\/div>/! b}; s/<div class="a_s _cf" id="ctn_freemium_article">.*<\/div>/unga~onga/}' noticia.html

sed -i -e '/<div class="a_r _cf" id="ctn_premium_article">/,/<\/div>/ {/<div class="a_r _cf" id="ctn_premium_article">/! {/<\/div>/! b}; s/<div class="a_r _cf" id="ctn_premium_article">.*<\/div>/onga~unga/}' noticia.html

# Sustituir el string temporal por el mensaje de No te suscribas
while read line; do

	if [[ $line =~ unga~onga ]];
	then
		echo ${line//unga~onga/'<div class=""><h1>&nbsp</h1></div><div class=""><h1>&nbsp</h1></div><span style="white-space: pre-line"></span><div class="a_s _cf" id="ctn_freemium_article"><h3 class="a_s_e">No te suscribas para seguir leyendo</h3><div class="a_s_ti">Lee sin límites</div><div class="a_s_b"><a class="button | flex btn btn-2" href="https://dialnet.unirioja.es/descarga/articulo/6518649.pdf">Seguir leyendo</a></div><div class="a_s_lo"><a id="loginLinkFreemium" href="https://info.nodo50.org/" cmp-ltrk="articulo_cuerpo" cmp-ltrk-idx="2" mrfobservableid="61e0e6ef-7da1-41f6-8b85-08750f5e7ed7">Nunca seré suscriptor</a></div></div>'}
				
	else
	
		echo ${line//onga~unga/'<div class=""><h1>&nbsp</h1></div><div class=""><h1>&nbsp</h1><span style="white-space: pre-line"></span><div class="a_r _cf" ><h3 class="a_r_e">No te registres para seguir leyendo</h3><div class="a_r_ts">Si tienes cuenta en EL PAÍS, puedes cancelarla ya mismo</div><div class="a_r_b"><a class="btn btn-7" href="https://sindominio.net/">NO INICIES SESIÓN</a><a class="btn btn-6" href="https://info.nodo50.org/" cmp-ltrk="articulo_cuerpo" cmp-ltrk-idx="0" mrfobservableid="30dceed7-90db-4e1c-8304-4dfe488d594e">NO TE REGISTRES</a></div><div class="a_r_ti _df _jc-c"><p id="btn_close_regis"><a class="button | flex" href="https://dialnet.unirioja.es/descarga/articulo/6518649.pdf">Ni te suscribas para leer sin límites</a></p></div></div>'}
	
	fi

# Guardar el código de la noticia modificado en un fichero temporal
done < noticia.html > noticia_tmp.html

# Renombrar el fichero temporal 
mv noticia_tmp.html noticia.html

# Abrir la noticia
open noticia.html
