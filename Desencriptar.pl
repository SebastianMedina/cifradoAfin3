use utf8; #Libreria para la codificación de 8 bits
use Unicode::Normalize;#libreria para normalizar las variables

$infile = "Enc - 3. Texto Encriptado.txt";#LLamar archivo cifrado
$outfile = "DesEnc - 4. Codigo Numerico.txt";#Crear archivo de salida
open INPUT_FILE, "<".$infile or die "cannot read file\n";#Abrir el archivo de entrada
open OUTPUT_FILE, ">>".$outfile or die "cannot write file\n";#Abrir el archivo de salida
@letras=("a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "ñ", "o", "p", 
"q", "r", "s", "t", "u", "v", "w", "x", "y", "z" );#variable array en donde se declara el alfabeto

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

close INPUT_FILE;#cierra el archivo de entrada
close OUTPUT_FILE;#cierra el archivo de salida

$infile = "DesEnc - 4. Codigo Numerico.txt";#Llama el archivo de salida anterior
$outfile = "DesEnc - 5. Filtro Tres.txt"; #Crear archivo de salida
open INPUT_FILE, "<".$infile or die "cannot read file\n";
open OUTPUT_FILE, ">>".$outfile or die "cannot write file\n";

   	my $a = 9841;#Valor de la clave "a"
	my $b = 10800;#Valor de la clave "b"
	my $n = 19683;#Valor de "N"
	
	my $r0 = $n;#Se iguala "N" a "R0"
	my $r1 = $a;#Se iguala "a" a "R1"
		
	my $q1 = int ($r0 / $r1);#Ecuacion para hallar el valor de "q"
	my $r2 = $r0 - ($q1 * $r1);#Ecuacion para hallar valor de "r2"
	
	@qx = ($q1);#Variable array donde se guarda los valores de "q"
	
	my $cont_qx = "";#Contador para variables de "q"
	
	#Arreglo para algoritmo extendido de euclides
	while ($r2 != 1)#repetir proceso hasta que "r2" sea igual a 1
	{
		$r1 = $r2;
				
		$q1 = int ($r1 / $r2);
		
		push @qx, $q1;
		$cont_qx = $cont_qx + 1;
		
		$r2 = $r0 - ($q1 * $r1);

	}
	
	#Se inicializan "t0" y "t1"
	my $t0 = 0;
	my $t1 = 1;
	
	my $t2 = "";#Se inicializa "t2"
	
	#Arreglo para encontrar la inversa de "a"
	for($j=0; $j <= $cont_qx; $j ++)
	{
		$t2 = $t0 - ($qx[$j] * $t1);
		
		$t0 = $t1;
						
	}
		if($t2 <  0)
	{
		$t2 = $t2 % $n;
	}
	#Se inicializan variables
	my $prim = "";
	my $seg = "";
	my $ter = "";
	
	my $num = 0;
	
	my $enc = 0;
	my $desenc = 0;
	
	my $prim_temp = 0;
	my $seg_temp = 0;
	my $ter_temp = 0;
	
	my $prim_final = "";
	my $seg_final = "";
	my $ter_final = "";
	
	my $str_final = "";
	
	my $stF = "";
	
#Arreaglo para realizar proceso de descifrado
while ($stF = <INPUT_FILE>)
{	
  
my @numeros = split / /,$stF;
	foreach $numero (@numeros)   
	{   
		#Arreglo para tomar de a dos numeros
		$prim = substr($numero, 0, 2); 
		$seg = substr($numero, 2, 2); 
		$ter = substr($numero, 4, 2); 
		
		#Ecuacion para pasar las letras a numeros
		$num = $prim * 729 + $seg * 27 + $ter;
		
		
		$enc = (($a * $num) + $b) % $n;
		
		#Ecuacion para encontrar nuevo valor nuemerico
		$desenc = (($num - $b) * $t2) % $n; 
		
		#Encontrar los nuevos caracteres del cifrado
		$prim_temp = int ($desenc / 729);
		$seg_temp = int (($desenc % 729) / 27);
		$ter_temp = (($desenc % 729) % 27);
		
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

$infile = "DesEnc - 5. Filtro Tres.txt";
$outfile = "DesEnc - 6. Desencriptacion Final.txt";
open INPUT_FILE, "<".$infile or die "cannot read file\n";
open OUTPUT_FILE, ">>".$outfile or die "cannot write file\n";

#Arreglo para quitar los caracteres "ñ"
while (my $str = <INPUT_FILE>)
{      	
	$str =~ s/\ //g;
	$str =~ s/\ñ/ /g;
	
	print OUTPUT_FILE $str;#imprime la variable en el archivo de salida
}
close INPUT_FILE;
close OUTPUT_FILE;
	
	







