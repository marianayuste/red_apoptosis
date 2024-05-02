Qué se hizo y en qué documentos:

Análisis 1. Perturbaciones quitando una por una las regulaciones de cada nodo 
    - Se hicieron las perturbaciones a mano, guardando cada una en un archivo distinto como 'n.txt' donde n es el número de perturbación, todo se guardó en carpeta analisis_1
    - Se obtuvieron los attrs de cada red perturbada en analisis_1.R, que también se encuentra en dicha carpeta. Se guardaron todos los attrs como números en decimal en documento 'attr_n.txt'
    - Se leyeron los resultados y total de perturbaciones con cambios en analisis_1.ipynb
    
    
Análisis 2. Perturbaciones bitflip a la red original
    - Se crearon las redes perturbadas en bitflip.ipynb
    - Se corrieron 150 de ellas (elegidas al azar) en bitflip.R
    - Se leyeron los resultados y total de perturbaciones con cambios en bitflip.ipynb

Análisis 3. Análisis asíncrono de la red
    - En analisis_3.R: Se corrió la red original.txt de forma asíncrona, desde un millón de estados iniciales elegidos aleatoriamente, y se guardaron los atractores obtenidos
    - Se leyeron los resultados en analisis_3.ipynb