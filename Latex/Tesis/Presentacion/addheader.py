import glob, os
import fileinput
c=1

headers = '\\documentclass[tikz]{standalone}\n \\usetikzlibrary{patterns}\\begin{document} \\begin{tikzpicture}'.split()
footers = '\\end{tikzpicture}\n\\end{document}'
for base, dirs, files in os.walk('/home/diego/Descargas/MarsellaOct2018/img/ARM'):
	for file in glob.glob(base+'/*.tex'):
		if c<2:
			
			print file
			for line in fileinput.input([file], inplace=True):
			    if fileinput.isfirstline():
			        print '\t'.join(headers)
			    print line,
			f=open(file, "a+")	
			f.write(footers)
			f.close()
			os.system('pdflatex -output-directory='+base+' '+file)



# headers = 'a b c d e'.split()
# for line in fileinput.input(['thefile.blah'], inplace=True):
#     if fileinput.isfirstline():
#         print '\t'.join(headers)
#     print line,
