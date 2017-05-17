use utf8; #Libreria para la codificación de 8 bits
use Unicode::Normalize;#libreria para normalizar las variables

$infile = "Texto Fuente.txt";#llamar al texto fuente
$outfile = "Enc - 1. Filtro Tres.txt";#Generar archivo de texto como resultado
open INPUT_FILE, "<".$infile or die "cannot read file\n";#Abrir el archivo de entrada
open OUTPUT_FILE, ">>".$outfile or die "cannot write file\n";#Abrir el archivo de salida
@letras=("a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "ñ", "o", "p", 
"q", "r", "s", "t", "u", "v", "w", "x", "y", "z" );#variable array en donde se declara el alfabeto

while (my $str = <INPUT_FILE>)
{             
	#Arreglo para quitar caracteres especiales y eliminar puntuacion.
	chomp ($str);
	my $sintildes = NFKD ( $str );
	$sintildes =~ s/\p{NonspacingMark}//g;              
	$output = lc $sintildes;#Pasar caracteres a minusculas
	#Quitar los siguientes signos de puntuacion.
	$output =~ s/\,//g;                            
	$output =~ s/\.//g;
	$output =~ s/\://g;
	$output =~ s/\;//g;
	$output =~ s/\(//g;
	$output =~ s/\)//g;
	$output =~ s/\-//g;

	#Agrupar cada palabra en segmentos de 3 caracteres
	my @palabras = split / /,$output;
	$output = "";
	#Arreglo para agregar el caracter "ñ"
	foreach $palabra (@palabras)   
	{                                
		my @separado = $palabra =~/..?.?/sg; 
		for ( @separado ) 
		{                                              
			if (length ($_) eq 1) #si queda un solo caracter
			{ 
				$output .= $_."ññ "; 
			}
			elsif (length ($_) eq 2 ) #Si quedan dos caracteres
			{ 
				$output .= $_."ñ "; 
			}
			else 
			{ 
				$output .= $_." "; 
			}                                             
		}
	}
	print OUTPUT_FILE $output;#Imprime la variable en el archivo de salida
}
close INPUT_FILE;#cierra el archivo de entrada
close OUTPUT_FILE;#cierra el archivo de salida

$infile = "Enc - 1. Filtro Tres.txt";#Llama el archivo de salida anterior
$outfile = "Enc - 2. Codigo Numerico.txt";#Genera nuevo archivo
open INPUT_FILE, "<".$infile or die "cannot read file\n";
open OUTPUT_FILE, ">>".$outfile or die "cannot write file\n";

#Arrelgo para asignar valor numerico a cada caracter
while ( $str = <INPUT_FILE>)
{
    for ( $i=0; $i <= 26 ; $i++ ) 
	{
	
		if( $i < 10)
		{
				
			$str =~ s/$letras[$i]/0$i/g;
				
		}		
		else
		{
			$str =~ s/$letras[$i]/$i/g;
		}		
	}	
	print OUTPUT_FILE $str;#imprime la variable en el archivo de salida
	$output = "";
}

close INPUT_FILE;
close OUTPUT_FILE;

$infile = "Enc - 2. Codigo Numerico.txt";#Llama el archivo de salida anterior
$outfile = "Enc - 3. Texto Encriptado.txt"; #Genera nuevo archivo
open INPUT_FILE, "<".$infile or die "cannot read file\n";
open OUTPUT_FILE, ">>".$outfile or die "cannot write file\n";

	#inicializa variables.
	my $prim = "";
	my $seg = "";
	my $ter = "";
	
	my $num = 0;
	
	my $a = 9841;#Valor de la clave "a"
	my $b = 10800;#Valor de la clave "b"
	my $n = 19683;#Valor de N
	
	my $enc = 0;#Inicializa variable cifrado
	
	my $prim_temp = 0;
	my $seg_temp = 0;
	my $ter_temp = 0;
	
	my $prim_final = "";
	my $seg_final = "";
	my $ter_final = "";
	
	my $str_final = "";
	
#Arreaglo para realizar proceso de cifrado	
while ($str = <INPUT_FILE>)
{ 
my @numeros = split / /,$str;
	foreach $numero (@numeros)   
	{   
		#Arreglo para tomar de a dos numeros
		$prim = substr($numero, 0, 2);
		$seg = substr($numero, 2, 2); 
		$ter = substr($numero, 4, 2); 
		
		#Ecuacion para pasar las letras a numeros
		$num = $prim * 729 + $seg * 27 + $ter;
		
		#Ecuacion para encontrar el nuevo valor nuemerico
		$enc = (($a * $num) + $b) % $n;
		
		#Encontrar los nuevos caracteres del cifrado
		$prim_temp = int ($enc / 729);
		$seg_temp = int (($enc % 729) / 27);
		$ter_temp = (($enc % 729) % 27);
		
		#Arreglo para coincidir los valores numericos con caracteres
		for ( $i=0; $i <= 26 ; $i++ ) 
		{
			if($i == $prim_temp)
			{
				$prim_final = $letras[$i];
			}			
			if($i == $seg_temp)
			{
				$seg_final = $letras[$i];
			}			
			if($i == $ter_temp)
			{
				$ter_final = $letras[$i];
			}								
		}
		#imprime la variable en el archivo de salida
		print OUTPUT_FILE $prim_final."".$seg_final."".$ter_final." ";
	}
}

close INPUT_FILE;
close OUTPUT_FILE;