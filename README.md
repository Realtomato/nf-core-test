安装环境：
   1. 需要安装Miniconda
   2. 使用conda创建相应的运行环境，并安装Nextflow, NF-Core等软件
         
            conda create -n nf-core-test nextflow=22.04.5 nf-core=2.4.1
         
            conda activate nf-core-test
            
   3. 将本流程下载到本地，切换到master分支
   
            git clone https://github.com/Realtomato/nf-core-test.git
            cd ./nf-core-test
            git checkout master
            
   4. 确认运行Nextflow流程的参数：
   
      --input <samplesheet.csv>               记录样本名和对应fastq路径的csv文件(单端测序的样本只需录入样本名和fastq_1，详细可见${projectDir}/assets/testdata/samplesheet.csv/, ${projectDir}是nextflow的主脚本所在路径，即./nf-core-test/)，格式如下：
      
            samplename, fastq_1, fastq2    

      --bwa_idxbase <bwa_idxbase>             bwa比对的参考基因组所在文件夹路径, default: ${projectDir}/assets/testdata/ref/

      --primer_bed <primer.bed>               ivar trim 需要的primer.bed文件

      --ref_seq <reference_sequence>          samtools mpileup 需要的reference_squence.fasta

      --outdir <outdir>                       输入结果保存路径, default: ${projectDir}/results

   5. 运行命令 
   
          nextflow run main.nf --input <samplesheet.csv> --bwa_idxbase <bwa_idxbase> --primer_bed <primer.bed> --ref_seq <reference_sequence> --outdir <outdir> -profile conda
