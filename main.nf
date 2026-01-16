process inputs {

  //fasta file name and GC cutoff content inputs Fasta file should be set as path and GC content as decimal, first GC content then file path
  input:
    val cutoff
    path fasta_file_path
    
  output:
    path output.txt
  
  //output script takes up the two variables given and uses them to create a new txt file if the GC content is greater than the cutoff
  script:
  """
  #!/usr/bin/env python3
  from Bio import SeqIO
  from Bio.SeqUtils import gc_fraction
  fasta_file = SeqIO.parse("$fasta_file_path", "fasta")
  cutoff = $cutoff
  with open("output.txt", "a") as out:
  	for record in fasta_file:
  		if gc_fraction(record.seq) > cutoff:
  		    SeqIO.write(record, out, "fasta")
  """
}
workflow {
inputs=channel.fromPath(param.input)
pross=inputs(inputFile,param.cutoff)
}
