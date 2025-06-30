process QC {
    input:
    path fastq
    path bam

    output:
    path "qc_report/"

    script:
    """
    mkdir -p qc_report
    NanoPlot --fastq $fastq --outdir qc_report
    samtools flagstat $bam > qc_report/bam_stats.txt
    """
}

workflow hurdle_nanomethvar_qc {
    take:
    fastq
    bam

    main:
    QC(fastq, bam)

    emit:
    QC.out
}
