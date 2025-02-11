## Introducción a la Genómica

## Introducción al software empleado en estudios de genómica de organismos no modelo

#### Objetivo 
Reconocer los principales formatos de datos genómicos.
Emplear algunos programas básicos para la limpieza de secuencias y la obtención de matrices de datos genómicos.

#### Material
Software: [FastQC](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/) (Andrews, 2010), [Trimmomatic](http://www.usadellab.org/cms/?page=trimmomatic) (Bolger et al., 2014), [ipyrad](https://ipyrad.readthedocs.io/en/master/) (Eaton y Overcast, 2020).

Secuencias genómicas: Datos crudos de secuenciación genómica disponibles en [GenBank](https://www.ncbi.nlm.nih.gov/sra/).  

#### Introducción
El desarrollo de los métodos de secuenciación y análisis de las moléculas informativas presentes en el mundo vivo (DNA, RNA, proteínas) ha tenido un auge importante en la última década del siglo XX y lo que va del siglo XXI. Como consecuencia de estos avances, en la actualidad es posible conocer casi completamente el contenido de genomas, transcriptomas, proteomas y metabolomas de cualquier especie, lo que permite nuevas oportunidades para estudiar disímiles aspectos de la biología de organismos y taxones (De León et al., 2023). 
Existen numerosas plataformas de secuenciación (por ejemplo: [Illumina](https://www.illumina.com/), [PacBio](https://www.pacb.com/), [IonTorrent](https://www.thermofisher.com/mx/es/home/brands/ion-torrent.html)) y tipos de datos que pueden ser generados. Estos pueden ir desde lecturas cortas de unos 150 pares de bases hasta moléculas completas de DNA que comprenden miles de pares de bases (Satam et al., 2023). Esta información genómica puede ser almacenada en varios tipos de formatos que pueden ser empleados en diversos programas. A continuación se listan algunos de los formatos más frecuentes:
- SRA (del inglés: *Sequence Raw Archives*, Archivos de lectura de secuencia): archivo de datos sin procesar y con información sobre la calidad de las bases. Puede consistir de archivos binarios como .bam, .sff y .hdf5 o formatos de texto como .fastq.
- FASTQ: es un formato basado en texto para almacenar una secuencia de nucleótidos e información sobre la calidad de estas bases. Tanto la letra de secuencia como la puntuación de calidad están codificadas con un único carácter .ascii. Un archivo FASTQ normalmente utiliza cuatro líneas por secuencia.
- SAM (del inglés: *Sequence Alignment and Map*, Archivo de Alineamiento y Mapeo de Secuencias): archivos de texto que contienen la información de alineación de múltiples secuencias mapeadas contra secuencias de referencia (generalmente un genoma).
- VCF (del inglés: *Variant Calling Format*, Formato de llamada de variantes): archivo de texto que contiene información de los nucleótidos en diferentes posiciones del genoma (generalmente polimorfismos simples de nucleótidos, SNPs por sus siglas en inglés), así como otras líneas de metadatos.
De manera general es posible identificar algunos pasos básicos en el procesamiento de los datos obtenidos en las plataformas de secuenciación para la obtención de matrices de datos genómicos (como los SNPs). Estas a su vez, puedan ser empleadas en posteriores estudios filogenómicos y poblacionales. En esta práctica realizaremos una introducción al procesamiento y análisis de algunos de los datos genómicos más comúnmente empleados en la actualidad (secuencias cortas generadas con tecnología de Illumina), cubriendo los pasos comprendidos desde la obtención de los datos crudos hasta la generación de los archivos .vcf (Figura 1).


<p align="center">
  <img src="[http://some_place.com/image.png](https://github.com/Ornitologia-MZFC/PCB_2025-2/blob/main/Unidad_6/images/flujo.png)" />
</p>

**Figura 1.** Pasos básicos para la obtención de matrices de datos genómicos a partir de secuencias cortas generadas con Illumina.

#### Protocolo y Cuestionario
**1- Descarga de secuencias genómicas**
Desde la página donde se almacenan los datos crudos de secuenciación genómica en GenBank (https://www.ncbi.nlm.nih.gov/sra/), introducir el nombre del taxón de interés. A continuación, hacer click izquierdo sobre cada uno de los elementos de la lista (se recomiendan descargar al menos cinco muestras). En la nueva ventana, hacer click derecho sobre el vínculo a las lecturas (Parte inferior de la ventana, indicado con la palabra “Runs”). En esta nueva ventana, ir hacia la pestaña “Download FASTA/FASTQ” y desde allí, presionar el botón de descarga.
Revisar los archivos descargados con la siguiente línea de código en la terminal:
 
¿Qué información está contenida en los archivos descargados? ¿Qué similitudes y diferencias tienen los archivos fastq con los archivos fasta descargados y utilizados en prácticas anteriores? ¿Qué significan los caracteres de la cuarta línea?

**2- Evaluación de la calidad de las secuencias**
Una vez descargado el programa FastQC (Andrews, 2010) desde https://www.bioinformatics.babraham.ac.uk/projects/fastqc/ y descompactado, introducir la siguiente línea de código en la terminal:
 
Los archivos obtenidos (en formato .html) pueden ser visualizados en cualquier navegador. Estos contienen información acerca de la calidad de las bases (Quality Phred scores), contenido de GC, adaptadores, bases no secuenciadas y longitud de secuencias (Figura 2).
 
**Figura 2.** Pestaña correspondiente al análisis de calidad de las secuencias en FastQC.
A partir de los archivos .html obtenidos, contestar: ¿Cuántas lecturas de secuencias tenemos? ¿Cuál es la longitud media? Compare estos valores entre las diferentes muestras.

**3- Edición y filtrado de las secuencias**
A partir de los archivos .fastq, cuya calidad fue evaluada con FastQC, realizar edición y filtrado de las lecturas de secuencias con Trimmomatic (Bolger et al., 2014) introduciendo la siguiente línea de código en la terminal:
 
Consultar el manual del programa y responder: ¿Qué parámetros utilizamos en este análisis? ¿Qué resultados podrían esperarse si modificamos los parámetros de SLIDINGWINDOW?
Analizar los fastq obtenidos en este paso con FastQC, ¿mejoró la calidad promedio de las lecturas? ¿Qué otros cambios notas respecto a los fastq originales?

**4- Creación de matriz de datos genómicos**
A partir de los archivos fastq generados en el paso anterior se construirá la matriz de datos genómicos que a su vez será empleada para los análisis siguientes. Para realizar esto, en primer lugar se debe crear el archivo de parámetros con el cual se correrá el programa ipyrad (Eaton y Overcast, 2020). 
 
Esta línea genera un archivo de texto con parámetros predefinidos. Posteriormente se debe revisar la documentación del programa, discutir el significado de cada uno de los parámetros que se considerarán para el análisis y realizar los cambios pertinentes. Una vez se haya modificado este archivo, ejecutar la corrida de ipyrad con el siguiente comando:
 
A partir de los archivos obtenidos, contestar: ¿Qué tipo de archivos hemos obtenido? ¿Qué diferencias presentan entre sí? Visualizar el archivo cuyo nombre termina en “stats.txt” y responder: ¿Cuántos SNPs componen la matriz? ¿Cuántos datos perdidos contiene la matriz? ¿Cuántos SNPs y datos perdidos hay por cada muestra?

Referencias
Andrews, S. (2010). FastQC: a quality control tool for high throughput sequence data.
Bolger, A. M., Lohse, M., y Usadel, B. (2014). Trimmomatic: A flexible trimmer for Illumina Sequence Data. Bioinformatics, btu170.
De León, L. F., Silva, B., Avilés-Rodríguez, K. J., y Buitrago-Rosas, D. (2023). Harnessing the omics revolution to address the global biodiversity crisis. Current Opinion in Biotechnology, 80, 102901.
Eaton, D.A.R. y Overcast I. (2020) “ipyrad: Interactive assembly and analysis of RADseq datasets.” Bioinformatics.
Moreira, L. R., Hernández-Baños, B. E., y Smith, B. T. (2020). Spatial predictors of genomic and phenotypic variation differ in a lowland Middle American bird (Icterus gularis). Molecular Ecology, 29(16), 3084-3101.
Satam, H., Joshi, K., Mangrolia, U., Waghoo, S., Zaidi, G., Rawool, S., ... y Malonia, S. K. (2023). Next-generation sequencing technology: current trends and advancements. Biology, 12(7), 997.

