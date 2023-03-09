安装环境：
   1. 需要安装Miniconda
   2. 使用conda创建相应的运行环境，并安装Nextflow, NF-Core等软件
         
            conda create -n nf-core-test nextflow=22.04.5 nf-core=2.4.1
         
            conda activate nf-core-test
   3. 确认运行Nextflow流程的参数：
   
      --input <samplesheet.csv>   格式如下：
      
            samplename, fastq_1, fastq2    

      --bwa_idxbase <bwa_idxbase>  bwa比对的参考基因组所在文件夹路径, default:"${projectDir}/assets/testdata/ref/"

      --primer_bed <primer.bed>  ivar trim 需要的primer.bed文件

      --ref_seq <reference_sequence>   samtools mpileup 需要的reference_squence.fasta

      --outdir <outdir> 输入结果保存路径, default:"${projectDir}/results"

   4. 运行命令 
   
          nextflow run main.nf --input <samplesheet.csv> --bwa_idxbase <bwa_idxbase> --primer_bed <primer.bed> --ref_seq <reference_sequence> --outdir <outdir> -profile conda
