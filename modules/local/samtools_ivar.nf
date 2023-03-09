process SAMTOOLS_IVAR {
    tag "$meta.id"
    label 'process_medium'

    conda "bioconda::ivar=1.3.1 bioconda::samtools=1.16.1"
    container "${ workflow.containerEngine == 'singularity' && !task.ext.singularity_pull_docker_container ?
        'https://depot.galaxyproject.org/singularity/ivar:1.3.1--h089eab3_0' :
        'quay.io/biocontainers/ivar:1.3.1--h089eab3_0' }"

    input:
    tuple val(meta), path(bam)
    path ref_seq

    output:
    tuple val(meta), path("*_consensus.fa"), emit: fa
    path "versions.yml"           , emit: versions

    when:
    task.ext.when == null || task.ext.when

    script:
    def args = task.ext.args ?: ''
    def prefix = task.ext.prefix ?: "${meta.id}"
    def suffix = task.ext.suffix ?: ""
    """
    samtools sort $args -o ${prefix}${suffix}.bam ${bam}
    samtools index ${prefix}${suffix}.bam
    samtools mpileup -A -d 1000 -B -Q 0 --reference ${ref_seq} ${prefix}${suffix}.bam \\
        | ivar consensus -p ${prefix}_consensus -n N

    cat <<-END_VERSIONS > versions.yml
    "${task.process}":
        samtools: \$(echo \$(samtools --version 2>&1) | sed 's/^.*samtools //; s/Using.*\$//')
        ivar: \$(echo \$(ivar version 2>&1) | sed 's/^.*iVar version //; s/ .*\$//')
    END_VERSIONS
    """
}
